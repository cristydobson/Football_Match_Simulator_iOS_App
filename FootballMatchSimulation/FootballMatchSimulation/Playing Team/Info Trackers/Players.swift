//
//  Players.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation


class Players {
  
  
  // MARK: - Properties
  
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
  
  func updatePlays(for position: Position) {
    positionPlays.updatePlays(for: position)
  }
  
  
  // MARK: - Skill Power
  
  func skillPower(for position: Position) -> Double {
    return SkillPower.getSkillPower(
      for: position, withPlayers: self)
  }
  
  
  // MARK: - Athletic Decay
  
  func totalAthleticDecay(for skillPower: Double, andPosition position: Position) -> Double {
    
    let plays = positionPlays.getPlays(for: position)
    
    return athleticDecay.getTotalAthleticDecay(
      skillPower: skillPower, plays: plays)
  }
  
  func updateAthleticDecayCoefficient(by amount: Double) {
    athleticDecay.updateCoefficient(by: amount)
  }
  
  
  // MARK: - Yellow Cards
  
  func addYellowCard(for position: Position) {
    updateYellowCards(for: position)
    isExpulsionByYellowCard(for: position)
  }
  
  func updateYellowCards(for position: Position) {
    yellowCards.updateCardCount(for: position)
  }
  
  func isExpulsionByYellowCard(for position: Position) {
    if yellowCards.isExpulsion(for: position) {
      removePlayer(from: position)
    }
  }
  
}
