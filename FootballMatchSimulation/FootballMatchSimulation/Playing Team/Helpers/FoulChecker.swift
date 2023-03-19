//
//  FoulChecker.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//



import Foundation


enum FoulPenalty {
  case freeKick
  case yellowCard
  case redCard
}


final class FoulChecker {
  
  
  static func committedFoul() -> Bool {
    return arc4random_uniform(6) == 0
  }
  
  static func getFoulType() -> FoulPenalty {
    let randomFoulGrade = arc4random_uniform(51)
    
    switch randomFoulGrade {
      case 49:
        return .yellowCard
      case 50:
        return .redCard
      default:
        return .freeKick
    }
  }
  
}




