//
//  PlayingTeam.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation
import Combine


enum TeamType {
  case homeTeam
  case visitorTeam
}


class PlayingTeam: CurrentTeam, ObservableObject {

  // MARK: - Properties
  
  // Team
  let team: Team
  private(set) var teamType: TeamType!
  
  // Team Info
  private(set) var name = ""
  private(set) var stadium = ""
  
  // Team Players
  private(set) var players: Players!
  
  // Current position being played
  private(set) var currentPosition: Position = .midfielder
  
  // Track Goals
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
  
  func setupTeam() {
    name = team.name
    stadium = team.stadium
    
    players = Players(
      keeper: team.keeper,
      defenders: team.defenders,
      midfielders: team.midfielders,
      attackers: team.attackers)
  }
  
  func setTeamType(for currentStadium: String) {
    teamType = (currentStadium == team.stadium) ?
      .homeTeam :
      .visitorTeam
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
  
  func resetPosition() {
    currentPosition = .midfielder
  }
  
  
  // MARK: - Get Field Position SkillPower
  
  /*
   Get the average SkillPower of all the players
   in the lineup with the same position.
   (e.g., all the midfielders)
   */
  func playersSkillPower() -> Double {
    
    // +1 Play to the field Position
    players.updatePlays(for: currentPosition)
    
    let totalSkillPower = totalSkillPower(for: currentPosition)
    print("TOTAL SKILL: \(totalSkillPower)!!!!")
    /*
     Get a random number in the range (0.0...totalSkillPower)
     to use in the head-to-head battle for the ball
     */
    let randomSkillPower = totalSkillPower.randomNumber()
    
    return randomSkillPower.rounded(to: 3)
  }
  
  func totalSkillPower(for position: Position) -> Double {
    // Calculate the SkillPower for a given position
    let skillPower = players.skillPower(for: position)
    
    // Calculate the total AthleticDecay so far in the game
    let athleticDecay = players.totalAthleticDecay(
      for: skillPower, andPosition: position)
    
    return skillPower - athleticDecay
  }
  
  
  // MARK: - Get Team Fouls
  
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
    print("HANDLE FOUL BY: \(name)!!!!!!")
    
    switch foulPenalty {
        
      case .yellowCard:
        print("YELLOW CARD!!!!!")
        players.addYellowCard(for: currentPosition)
        
      case .redCard:
        print("RED CARD!!!!!")
        
        players.removePlayer(from: currentPosition)
        
      default:
        print("GO ON!!")
    }
  }
  
  
  // Handle the team receiving the foul
  func handleReceivedFoul(_ foulPenalty: FoulPenalty) {
    print("HANDLE FOUL ON: \(name)!!!!!!")
    
    /*
     Receiving a foul affects the players fitness
     negatively
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
