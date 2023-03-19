//
//  YellowCardTracker.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//



import Foundation


class YellowCardTracker {
  
  var defenderCount = 0
  var midFielderCount = 0
  var attackerCount = 0
  
  func updateCardCount(for position: Position) {
    switch position {
      case .defender:
        defenderCount += 1
      case .midfielder:
        midFielderCount += 1
      default:
        attackerCount += 1
    }
  }
  
  func isExpulsion(for position: Position) -> Bool {
    switch position {
      case .defender:
        return defenderCount % 2 == 0
      case .midfielder:
        return midFielderCount % 2 == 0
      default:
        return attackerCount % 2 == 0
    }
  }
  
}
