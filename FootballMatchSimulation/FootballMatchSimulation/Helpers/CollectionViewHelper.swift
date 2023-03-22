//
//  CollectionViewHelper.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import UIKit


struct CollectionViewHelper {
  
  static func createLayout(for frame: CGRect, andHeight multiplier: CGFloat) -> UICollectionViewFlowLayout {
    
    let cellWidth = frame.width
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(
      top: 20, left: 0, bottom: 40, right: 0)
    layout.minimumLineSpacing = 0
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth*multiplier)
    
    return layout
  }
  
  static func createCollectionView(with frame: CGRect, andLayout layout: UICollectionViewFlowLayout) -> UICollectionView {
    
    let collectionView = UICollectionView(
      frame: frame, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    
    return collectionView
  }
  
}
