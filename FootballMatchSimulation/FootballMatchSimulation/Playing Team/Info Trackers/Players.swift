///
/// Players.swift
///
/// All the players currently
/// playing a Match
///
/// Created by Cristina Dobson
///


import Foundation


class Players {
  
  
  // MARK: - Properties
  
  // Players per Position
  private(set) var keeper: Player
  private(set) var defenders: [Player]
  private(set) var midfielders: [Player]
  private(set) var attackers: [Player]
  
  // Players Info Trackers
  private(set) var positionPlays: PositionPlays!
  private(set) var athleticDecay: AthleticDecay!
  private(set) var yellowCards: YellowCardTracker!
  
  
  // MARK: - Init Method
  
  init(keeper: Player, defenders: [Player], midfielders: [Player], attackers: [Player]) {
    self.keeper = keeper
    self.defenders = defenders
    self.midfielders = midfielders
    self.attackers = attackers
    
    positionPlays = PositionPlays()
    athleticDecay = AthleticDecay()
    yellowCards = YellowCardTracker()
  }
  
  
  // MARK: - Methods
  
  /*
   Remove a player from the lineup after
   getting a red card or two yellow cards
   */
  func removePlayer(from position: Position) {
    switch position {
        
      case .defender:
        defenders.removeLast()
        
      case .midfielder:
        midfielders.removeLast()
        
      default:
        attackers.removeLast()
    }
  }
  
  
  // MARK: - Position Plays
  
  // Add +1 Play to a given Position in a Team
  func updatePlays(for position: Position) {
    positionPlays.updatePlays(for: position)
  }
  
  
  // MARK: - Skill Power
  
  // Calculate the SkillPower for a given Position
  func skillPower(for position: Position) -> Double {
    return SkillPower.getSkillPower(
      for: position, withPlayers: self)
  }
  
  
  // MARK: - Athletic Decay
  
  /*
   Calculate the total AthleticDecay for a
   Position's SkillPower
   */
  func totalAthleticDecay(for skillPower: Double, andPosition position: Position) -> Double {
    let plays = positionPlays.getPlays(for: position)
    
    return athleticDecay.getTotalAthleticDecay(
      skillPower: skillPower, plays: plays)
  }
  
  /*
   Increase the Team's Athletic Decay coefficient
   after receiving a foul
   */
  func updateAthleticDecayCoefficient(by amount: Double) {
    athleticDecay.updateCoefficient(by: amount)
  }
  
  
  // MARK: - Yellow Cards
  
  /*
   Add +1 to the received yellow cards for the
   position that committed the foul
   */
  func addYellowCard(for position: Position) {
    updateYellowCards(for: position)
    isExpulsionByYellowCard(for: position)
  }
  
  func updateYellowCards(for position: Position) {
    yellowCards.updateCardCount(for: position)
  }
  
  /*
   Check if the Position that committed the foul has
   2 yellow cards already, if so, then remove a player
   from the Team's lineup
   */
  func isExpulsionByYellowCard(for position: Position) {
    if yellowCards.isExpulsion(for: position) {
      removePlayer(from: position)
    }
  }
  
}
