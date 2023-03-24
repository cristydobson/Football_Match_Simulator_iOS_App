//
//  DataLoader.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/17/23.
//


import Foundation


class DataLoader {

  
  // MARK: - Save Data
  
  static func save<T: Codable>(_ object: T, to fileName: String) throws {
    
    let url = getDocumentURL(for: fileName)
    
    do {
      let data = try JSONEncoder().encode(object)
      try data.write(to: url, options: .atomic)
    }
    catch {
      print("Failed to save JSON data with error: \(error)!!")
      throw error
    }
  }
  
  
  // MARK: - Retrieve Data
  
  static func loadDataFromDirectory<T: Codable>(_ type: T.Type, from fileName: String) throws -> T? {
    let url = getDocumentURL(for: fileName)
    return try loadData(T.self, from: url)
  }
  
  static func loadDataFromBundle<T: Codable>(_ type: T.Type, from fileName: String) throws -> T? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
      return try loadData(T.self, from: url)
    }
    return nil
  }
  
  static func loadData<T: Codable>(_ type: T.Type, from url: URL) throws -> T? {
    
    do {
      let data = try Data(contentsOf: url)
      return try JSONDecoder().decode(T.self, from: data)
    }
    catch {
      print("Failed to retrieve JSON data with error: \(error)!!")
      throw error
    }
  }
  
  
  // MARK: - Create Document URL
  
  static func getDocumentURL(for fileName: String) -> URL {
    
    let directoryURL = FileManager.default.urls(
      for: .documentDirectory, in: .userDomainMask)[0]
    
    let url = directoryURL.appending(component: fileName)
      .appendingPathExtension("json")
    
    return url
  }
  
}


