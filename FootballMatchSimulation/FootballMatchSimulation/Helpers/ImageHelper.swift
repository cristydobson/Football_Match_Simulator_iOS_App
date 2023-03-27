///
/// ImageHelper.swift
///
/// Created by Cristina Dobson
/// 


import Foundation
import UIKit


struct ImageHelper {
  
  // Get an image from the Bundle
  static func getImage(_ name: String) -> UIImage? {
    
    if let url = Bundle.main.url(forResource: name, withExtension: "png") {
      
      let imgData = try! Data(contentsOf: url)
      return UIImage(data: imgData)
    }
    return nil
  }
  
}

