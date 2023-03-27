///
/// MockDataLoader.swift
///
/// Created by Cristina Dobson
///


import Foundation


class MockDataLoader {
  
  
  static let decoder = JSONDecoder()

  // Load the mock JSON data from Bundlw
  static func loadDataFromBundle<T: Codable>(_ type: T.Type, from fileName: String) throws -> T? {

    if let url = Bundle(for: MockDataLoader.self).url(forResource: fileName, withExtension: "json") {
      return try loadData(T.self, from: url)
    }
    return nil
  }
  
  static func loadData<T: Codable>(_ type: T.Type, from url: URL) throws -> T? {
    
    do {
      let data = try Data(contentsOf: url)
      return try decoder.decode(T.self, from: data)
    }
    catch {
      print("Failed to retrieve JSON data with error: \(error)!!")
      throw error
    }
  }
  
  
}
