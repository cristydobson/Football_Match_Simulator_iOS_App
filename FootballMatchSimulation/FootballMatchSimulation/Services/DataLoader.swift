//
//  DataLoader.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/17/23.
//


import Foundation


class DataLoader {
  
  static func retrieveData<T: Codable>(_ type: T.Type, from fileName: String) throws -> T? {
    
    if let path = Bundle.main.url(forResource: fileName, withExtension: "json") {
      
      do {
        
        let data = try Data(contentsOf: path)
        return try JSONDecoder().decode(T.self, from: data)
      }
      catch {
        print("Failed to retrieve JSON data with error: \(error)!!")
        throw error
      }
      
    }
    
    return nil
  }
  
}
