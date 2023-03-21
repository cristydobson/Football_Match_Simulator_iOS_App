//
//  ColorHelper.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation
import UIKit


extension UIColor {
  
  static let lightBlue = UIColor(red: 108/255, green: 170/255,
                                 blue: 165/255, alpha: 1)
  
  static let mediumBlue = UIColor(red: 11/255, green: 170/255,
                                  blue: 184/255, alpha: 1)
  
  static let darkerBlue = UIColor(red: 0/255, green: 113/255,
                                  blue: 123/255, alpha: 1)
  
  // Support custom colors for dark and light themes
//  static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
//    return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
//  }
  
}
