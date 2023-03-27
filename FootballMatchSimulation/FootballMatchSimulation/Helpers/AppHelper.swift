///
/// AppHelper.swift
///
/// Created by Cristina Dobson
///


import Foundation


struct AppHelper {
  
  // Check if it's the app's first launch
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
