//
//  PositionPlays.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation


/*
 Each Play equals 1 minute
 */
class PositionPlays {
  
  // MARK: - Properties
  
  private var keeper = 0
  private var defenders = 0
  private var midfielders = 0
  private var attackers = 0
  
  
  // MARK: - Methods
  
  func updatePlays(for position: Position) {
    switch position {
      case .keeper:
        keeper += 1
      case .defender:
        defenders += 1
        midfielders += 1
      case .midfielder:
        midfielders += 1
      case .attacker:
        attackers += 1
        midfielders += 1
    }
  }
  
  func getPlays(for position: Position) -> Int {
    switch position {
      case .keeper:
        return keeper
      case .defender:
        return defenders
      case .midfielder:
        return midfielders
      case .attacker:
        return attackers
    }
  }
  
}




