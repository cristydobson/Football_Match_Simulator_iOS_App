///
/// PlayingTeam.swift
///
/// Handles the team that is currently playing
/// a match in the Game Simulation.
///
/// Created by Cristina Dobson
///


import Foundation
import Combine


class PlayingTeam: CurrentTeam, ObservableObject {

  
  // MARK: - Properties
  
  // Team
  let team: Team
  
  // Team's Info
  private(set) var name = ""
  private(set) var stadium = ""
  
  // Team's Players
  private(set) var players: Players!
  
  // Current position being played in the field
  private(set) var currentPosition: Position = .midfielder
  
  // Track Team's scored Goals
  @Published private(set) var goals = 0
  
  
  var isGoalKeeper: Bool {
    return currentPosition == .keeper
  }
  
  
  // MARK: - Init Method
  
  init(team: Team) {
    self.team = team
    
    setupTeam()
  }
  
  
  // MARK: - Setup Methods
  
  // Setup the current Playing Team's info
  func setupTeam() {
    name = team.name
    stadium = team.stadium
    
    players = Players(
      keeper: team.keeper,
      defenders: team.defenders,
      midfielders: team.midfielders,
      attackers: team.attackers)
  }
  
  
  // MARK: - Update Goals
  
  func updateGoals() {
    goals += 1
  }
  
  
  // MARK: - Get Field Position
  /*
   Get the field positions of the players
   battling for the ball
   */
  
  // Winner of the head-to-head battle for the ball
  func nextPosition() {
    currentPosition = currentPosition.nextPosition()
  }
  
  // Loser of the head-to-head battle for the ball
  func fallBackPosition(against rivalPosition: Position) {
    currentPosition = currentPosition.fallbackPosition(against: rivalPosition)
  }
  
  // After half-time, they must return to the midfield
  func resetPosition() {
    currentPosition = .midfielder
  }
  
  
  // MARK: - Get SkillPower
  
  /*
   Get the average SkillPower of all the players
   in the lineup with the same position.
   Add +1 for every player in the lineup.
   (e.g., all the midfielders)
   */
  func playersSkillPower() -> Double {
    
    /*
     +1 Play to the field Position.
     This increases the Athletic decay.
     The more a position plays, the less fit they become.
     */
    players.updatePlays(for: currentPosition)
    
    // Get the SkillPower for the current playing position
    let totalSkillPower = totalSkillPower(for: currentPosition)

    /*
     Get a random number in the range (0.0...totalSkillPower)
     to use in the head-to-head battle for the ball
     */
    let randomSkillPower = totalSkillPower.randomNumber()
    
    return randomSkillPower.rounded(to: 3)
  }
  
  // Calculate the total SkillPower for a given position
  func totalSkillPower(for position: Position) -> Double {
    
    let skillPower = players.skillPower(for: position)
    
    /*
     Calculate the total AthleticDecay for the position
     so far in the game
     */
    let athleticDecay = players.totalAthleticDecay(
      for: skillPower, andPosition: position)
    
    return skillPower - athleticDecay
  }
  
  
  // MARK: - Get Team Fouls
  
  /*
   Ask if the Players committed a foul
   during the head-to-head battle
   */
  func commitedFoul() -> Bool {
    return FoulChecker.committedFoul()
  }
  
  // Get a random FoulPenalty type
  func getFoulPenaltyType() -> FoulPenalty {
    return FoulChecker.getFoulType()
  }
  
}


// MARK: - Handle Team Fouls

extension PlayingTeam {
  
  /*
   Handle the team committing the foul.
   
   YELLOW Card:
   - Update the yellow card count for a given position.
   - Check if the position has 2 yellow cards, which
   should then remove a player from the field permanently.
   
   RED Card:
   - Remove a player from the field permanently.
   
   FREEKICK:
   - Do nothing.
   */
  func handleCommittedFoul(_ foulPenalty: FoulPenalty) {
    
    switch foulPenalty {
        
      case .yellowCard:
        players.addYellowCard(for: currentPosition)
        
      case .redCard:
        players.removePlayer(from: currentPosition)
        
      default:
        print("GO ON!!")
    }
  }
  
  
  // Handle the team receiving the foul
  func handleReceivedFoul(_ foulPenalty: FoulPenalty) {
    /*
     Receiving a foul affects the players
     fitness negatively
     */
    switch foulPenalty {
        
      case .yellowCard:
        players.updateAthleticDecayCoefficient(by: 0.002)
        
      case .redCard:
        players.updateAthleticDecayCoefficient(by: 0.003)
        
      default:
        players.updateAthleticDecayCoefficient(by: 0.001)
    }
  }
  
}
