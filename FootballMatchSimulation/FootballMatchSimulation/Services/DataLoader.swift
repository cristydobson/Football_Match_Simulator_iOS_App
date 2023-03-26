///
/// DataLoader.swift
///
/// Retrieve from and Save Data to DocumentDirectory
/// in JSON format
///
/// Created by Cristina Dobson
///


import Foundation


class DataLoader {

  
  static let encoder = JSONEncoder()
  static let decoder = JSONDecoder()
  
  
  // MARK: - Save Data
  
  // Save encoded data to DocumentDirectory
  static func save<T: Codable>(_ object: T, to fileName: String) throws {

    let url = getDocumentURL(for: fileName)

    do {
      let data = try encoder.encode(object)
      try data.write(to: url, options: .atomic)
    }
    catch {
      print("Failed to save JSON data with error: \(error)!!")
      throw error
    }
  }
  
  
  // MARK: - Retrieve Data
  
  // Retrieve and decode data from DocumentDirectory
  static func loadDataFromDirectory<T: Codable>(_ type: T.Type, from fileName: String) throws -> T? {
    let url = getDocumentURL(for: fileName)
    return try loadData(T.self, from: url)
  }
  
  /*
   Retrieve and decode data from Bundle, if it doesn't exist
   in DocumentDirectory
   */
  static func loadDataFromBundle<T: Codable>(_ type: T.Type, from fileName: String) throws -> T? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
      return try loadData(T.self, from: url)
    }
    return nil
  }
  
  // Retrieve data from a given URL
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
  
  
  // MARK: - Create Document URL
  
  // Create a URL to retrieve from or save data to DocumentDirectory
  static func getDocumentURL(for fileName: String) -> URL {
    
    let directoryURL = FileManager.default.urls(
      for: .documentDirectory, in: .userDomainMask)[0]
    
    let url = directoryURL.appending(component: fileName)
      .appendingPathExtension("json")
    
    return url
  }
  
}


