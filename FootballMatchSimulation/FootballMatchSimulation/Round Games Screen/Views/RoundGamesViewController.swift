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
  
  private let viewModel = RoundGamesViewModel()
  
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
    view.addGradientBackground()
  }
  
  func addViews() {
    
    collectionView = RoundGamesCollectionView(
      frame: view.frame, controller: self, round: round)
    collectionView.round = round
    view.addSubview(collectionView)
    
  }

  
  

  
  
}
