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
  
  
  // MARK: - Init Method
  
  init(keeper: Player, defenders: [Player], midfielders: [Player], attackers: [Player]) {
    self.keeper = keeper
    self.defenders = defenders
    self.midfielders = midfielders
    self.attackers = attackers
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
  
}
