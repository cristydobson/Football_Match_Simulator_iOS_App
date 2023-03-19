//
//  DoubleHelper.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/18/23.
//


import Foundation


extension Double {
  
  func randomNumber() -> Double {
    return Double.random(in: 0.0...self)
  }
  
  func average(of count: Int) -> Double {
    return self / Double(count)
  }
  
  func rounded(to decimalPlaces: Int) -> Double {
    let divisor = pow(10.0, Double(decimalPlaces))
    return (self * divisor).rounded() / divisor
  }
  
}


// MARK: - Double Helper

struct DoubleHelper {
  
  /*
   Get the average of a Double,
   then round it to 2 places.
   */
  static func getRoundedAverageNumber(for double: Double, withCount count: Int) -> Double {
    return double.average(of: count).rounded(to: 2)
  }
  
}
