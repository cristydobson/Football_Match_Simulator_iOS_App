//
//  RoundCardCollectionView.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/21/23.
//


import Foundation
import UIKit


class RoundCardCollectionView: UIView {
  
  
  // MARK: - Properties
  
  var collectionView: UICollectionView!
  let cellID = "RoundCardCell"
  
  
  
  // MARK: - Init Method
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupCollectionView()
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    backgroundColor = .clear
  }
  
  func setupCollectionView() {
    
    let cellWidth = frame.width-24
    
    // CollectionView Layout
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(
      top: 20, left: 0, bottom: 20, right: 0)
    layout.minimumLineSpacing = 0
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth*0.7)
    
    
    // Instantiate CollectionView
    collectionView = UICollectionView(
      frame: frame, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.dataSource = self
    collectionView.delegate = self
    
    // Register the CollectionView's cell
    collectionView.register(RoundCardCell.self, forCellWithReuseIdentifier: cellID)
    
    // Add CollectionView to current View
    addSubview(collectionView)

  }
  
  
  
  
}


// MARK: - UICollectionViewDataSource

extension RoundCardCollectionView: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 12
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellID, for: indexPath) as! RoundCardCell
    return cell
  }
  
}


// MARK: - UICollectionViewDelegate

extension RoundCardCollectionView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
  
  func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    
    return true
  }
  
}















