//
//  PlayingTeam.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation


enum TeamType {
  case homeTeam
  case visitorTeam
}


class PlayingTeam: CurrentTeam {

  // MARK: - Properties
  
  let team: Team
  
  private(set) var name = ""
  private(set) var currentPosition: Position = .midfielder
  
  private(set) var teamType: TeamType!
  
  // Team Players
  private(set) var players: Players!
  
  // Tracking Team Info
  private(set) var goals = 0
  private(set) var yellowCardTracker: YellowCardTracker!
  private(set) var positionPlays: PositionPlays!
  private(set) var athleticDecay: AthleticDecay!
  
  
  // MARK: - Init Method
  
  init(team: Team) {
    self.team = team
    
    setupTeam()
    setupTrackers()
  }
  
  
  // MARK: - Setup Methods
  
  func setupTeam() {
    name = team.name
    
    players = Players(
      keeper: team.keeper, defenders: team.defenders,
      midfielders: team.midfielders, attackers: team.attackers)
  }
  
  func setTeamType(for stadium: String) {
    teamType = stadium == team.stadium ? .homeTeam : .visitorTeam
  }
  
  func setupTrackers() {
    yellowCardTracker = YellowCardTracker()
    positionPlays = PositionPlays()
    athleticDecay = AthleticDecay()
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
  
  
  // MARK: - Get Field Position SkillPower
  
  /*
   Get the average SkillPower of all the players
   in the lineup with the same position.
   (e.g., all the midfielders)
   */
  func playersSkillPower() -> Double {
    
    // +1 Play to the field Position
    positionPlays.updatePlays(for: currentPosition)
    let plays = positionPlays.getPlays(for: currentPosition)
    
    // Calculate the SkillPower for a given position
    let skillPower = SkillPower.getSkillPower(
      for: currentPosition, withPlayers: players)
    
    // Calculate the total AthleticDecay so far in the game
    let athleticDecay = athleticDecay.getTotalAthleticDecay(
      skillPower: skillPower, plays: plays)
    
    let totalSkillPower = skillPower - athleticDecay
    
    /*
     Get a random number in the range (0.0...totalSkillPower)
     to use in the head-to-head battle for the ball
     */
    let randomSkillPower = totalSkillPower.randomNumber()
    
    return randomSkillPower.rounded(to: 3)
  }
  
}


// MARK: - Handle Team Fouls

extension PlayingTeam {
  
  func commitedFoul() -> Bool {
    return FoulChecker.committedFoul()
  }
  
  // Get a random FoulPenalty type
  func getFoulPenaltyType() -> FoulPenalty {
    return FoulChecker.getFoulType()
  }
  
  /*
   Handle the team committing the foul.
   
   YELLOW Card:
   - Update the yellow card count for a given position.
   - Check if the position has 2 yellow cards, which
   should then remove a player from the field permanently.
   
   RED Card:
   - Remove a player from the field permanently.
   */
  func handleCommittedFoul(_ foulPenalty: FoulPenalty) {
    print("HANDLE FOUL BY: \(name)!!!!!!")
    
    switch foulPenalty {
      case .yellowCard:
        print("YELLOW CARD!!!!!")
        
        yellowCardTracker.updateCardCount(for: currentPosition)
        
        if yellowCardTracker.isExpulsion(for: currentPosition) {
          players.removePlayer(from: currentPosition)
        }
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
        athleticDecay.updateCoefficient(by: 0.002)
      case .redCard:
        athleticDecay.updateCoefficient(by: 0.003)
      default:
        athleticDecay.updateCoefficient(by: 0.001)
    }
  }
  
  
  
}
