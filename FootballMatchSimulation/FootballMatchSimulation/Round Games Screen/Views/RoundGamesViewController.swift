//
//  RoundGamesViewController.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import UIKit
import Combine

class RoundGamesViewController: UIViewController, ObservableObject {
  
  
  // MARK: - Properties
    
  private let viewModel = RoundGamesViewModel()
  
  @Published var updatedScores = false
  
  var round: Round!
  var collectionView: RoundGamesCollectionView!
  
  
  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBackground()
    addViews()
        
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    transitionToPortrait()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    updatedScores = collectionView.updatedScores
  }
  
  func transitionToPortrait() {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
       appDelegate.appOrientation == .landscape {
      appDelegate.appOrientation = .portrait
    }
  }
  
  
  // MARK: - Setup Methods
  
  func setupBackground() {
    view.addBlueGradientBackground()
    
    for view in navigationController!.navigationBar.subviews {
      if let titleLabel = view as? UILabel {
        titleLabel.text = "\(round.name)"
      }
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
    
  }
  

  
}
