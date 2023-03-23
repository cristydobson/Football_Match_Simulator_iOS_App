//
//  AppHelper.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/23/23.
//


import Foundation


struct AppHelper {
  
  static func isApplicationFirstLaunch() -> Bool {
    
    let key = "appHasLaunched"
    let userDefaults = UserDefaults.standard
    
    if userDefaults.string(forKey: key) != nil {
      return true
    }
    
    userDefaults.set(true, forKey: key)
    return false
  }
  
}
