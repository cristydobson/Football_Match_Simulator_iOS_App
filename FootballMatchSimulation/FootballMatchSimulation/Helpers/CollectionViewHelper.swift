//
//  CollectionViewHelper.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import UIKit


struct CollectionViewHelper {
  
  static func createCollectionView(with frame: CGRect, andLayout layout: UICollectionViewFlowLayout) -> UICollectionView {
    
    let collectionView = UICollectionView(
      frame: frame, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    
    return collectionView
  }
  
}
