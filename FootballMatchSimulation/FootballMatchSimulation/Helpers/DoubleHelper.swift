///
/// DoubleHelper.swift
///
/// Created by Cristina Dobson
///


import Foundation


extension Double {
  
  // Get a random Double
  func randomNumber() -> Double {
    return Double.random(in: 0.0...self)
  }
  
  // Get the average
  func average(of count: Int) -> Double {
    return self / Double(count)
  }
  
  /*
   Round a Double to a given number
   of decimal places
   */
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
