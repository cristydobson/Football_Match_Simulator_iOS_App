///
/// CollectionViewHelper.swift
///
/// Created by Cristina Dobson
///


import Foundation
import UIKit


struct CollectionViewHelper {
  
  // Create a collectionView
  static func createCollectionView(with frame: CGRect, andLayout layout: UICollectionViewFlowLayout) -> UICollectionView {
    
    let collectionView = UICollectionView(
      frame: frame, collectionViewLayout: layout)
    
    collectionView.backgroundColor = .clear
    
    return collectionView
  }
  
}
