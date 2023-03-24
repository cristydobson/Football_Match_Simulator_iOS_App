//
//  RoundGamesViewController.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import UIKit


class RoundGamesViewController: UIViewController {
  
  
  // MARK: - Properties
      
  var round: Round!
  var collectionView: RoundGamesCollectionView!
  
  
  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBackground()
    addViews()
  }
  
  
  // MARK: - Setup Methods
  
  func setupBackground() {
    view.addBlueGradientBackground()
    
    for view in navigationController!.navigationBar.subviews {
      setViewTitle(on: view)
    }
  }
  
  func setViewTitle(on label: UIView) {
    if let titleLabel = label as? UILabel {
      titleLabel.text = "\(round.name)"
    }
  }
  
  func addViews() {
    
    /*
     Collection View
     */
    collectionView = RoundGamesCollectionView(
      frame: view.frame, controller: self, round: round)
    collectionView.round = round
    
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
        
  }

}
