///
/// YellowCardTracker.swift
///
/// Keep track of how many yellow cards
/// a Position in a Team gets.
///
/// Created by Cristina Dobson
///


import Foundation


class YellowCardTracker {
  
  
  // MARK: - Properties
  
  /*
   Position in a Team that
   can get yellow cards
   */
  var defenderCount = 0
  var midFielderCount = 0
  var attackerCount = 0
  
  
  // MARK: - Methods
  
  // Increase the yellow card count by 1
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
  
  // Check if a given Position has 2 yellow cards
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
