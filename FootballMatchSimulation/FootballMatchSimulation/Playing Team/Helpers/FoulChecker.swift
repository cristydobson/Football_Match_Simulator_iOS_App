///
/// FoulChecker.swift
///
/// Determine whether players have
/// committed fouls and the type of
/// the penalty received.
///
/// Created by Cristina Dobson
///


import Foundation

/*
 Type of penalty received
 after committing a foul
 */
enum FoulPenalty {
  case freeKick
  case yellowCard
  case redCard
}


final class FoulChecker {
  
  // Determine if they have committed a foul
  static func committedFoul() -> Bool {
    return arc4random_uniform(6) == 0
  }
  
  /*
   Determine the type of penalty received for
   committing a foul.
   Red and yellow card have the lowest chance.
   */
  static func getFoulType() -> FoulPenalty {
    let randomFoulGrade = arc4random_uniform(51)
    
    switch randomFoulGrade {
        
      case 48, 49:
        return .yellowCard
        
      case 50:
        return .redCard
        
      default:
        return .freeKick
    }
  }
  
}




