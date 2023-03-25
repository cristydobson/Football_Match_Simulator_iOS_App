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
  
  var dismissControllerButton: UIButton!
  
  
  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTitle()
    setupBackground()
    addViews()
  }

  
  // MARK: - Setup Methods
  
  func setupTitle() {
    
  }
  
  func setupBackground() {
    view.addBlueGradientBackground()
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
    
    let collectionViewContainer = getEmptyView()
    view.addSubview(collectionViewContainer)
    
    
    let cvFrame = CGRect(
      origin: CGPoint(x: 0, y: 0),
      size: CGSize(width: view.frame.width*0.9, height: view.frame.height))
    collectionView = RoundGamesCollectionView(
      frame: cvFrame, controller: self, round: round)
    collectionView.round = round
    collectionViewContainer.addSubview(collectionView)

    
    NSLayoutConstraint.activate([
      collectionViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
      collectionViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      collectionViewContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      collectionViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    
    // Dismiss button
    dismissControllerButton = createDismissButton()
    
    NSLayoutConstraint.activate([
      dismissControllerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      dismissControllerButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      dismissControllerButton.setWidthContraint(by: 60),
      dismissControllerButton.heightAnchor.constraint(equalTo: dismissControllerButton.widthAnchor, multiplier: 1)
    ])
        
  }
  
  
  // MARK: - View Helper Methods
  
  func getEmptyView() -> UIView {
    return ViewHelper.createEmptyView()
  }
  
  func createDismissButton() -> UIButton {
    let button = UIButton()
    button.setTitle("X", for: .normal)
    
    button.addTarget(
      self,
      action: #selector(dismissControllerAction),
      for: .touchUpInside)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(button)
    
    return button
  }
  
  
  // MARK: - Button Actions
  
  @objc func dismissControllerAction() {
    dismiss(animated: true)
  }
  
}
