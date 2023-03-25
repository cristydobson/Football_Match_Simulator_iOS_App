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
    
    let safeArea = view.safeAreaLayoutGuide
    
    /*
     Collection View
     */
    
    let collectionViewContainer = getEmptyView()
    view.addSubview(collectionViewContainer)
    
    collectionView = setupRoundGamesCollectionView()
    collectionViewContainer.addSubview(collectionView)

    
    NSLayoutConstraint.activate([
      collectionViewContainer.topAnchor.constraint(
        equalTo: view.topAnchor),
      collectionViewContainer.bottomAnchor.constraint(
        equalTo: view.bottomAnchor),
      collectionViewContainer.widthAnchor.constraint(
        equalTo: view.widthAnchor, multiplier: 0.85),
      collectionViewContainer.centerXAnchor.constraint(
        equalTo: view.centerXAnchor)
    ])
    
    
    // Dismiss button
    dismissControllerButton = createDismissButton()
    
    NSLayoutConstraint.activate([
      dismissControllerButton.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor, constant: 48),
      dismissControllerButton.topAnchor.constraint(
        equalTo: view.topAnchor, constant: 24),
      dismissControllerButton.heightAnchor.constraint(equalTo: dismissControllerButton.widthAnchor, multiplier: 1),
      dismissControllerButton.setWidthContraint(by: 60)
    ])
    
    
    // Title Label
    let titleLabel = getLabel()
    view.addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
        
  }
  
  func setupRoundGamesCollectionView() -> RoundGamesCollectionView {
    let cvFrame = CGRect(
      origin: CGPoint(x: 0, y: 0),
      size: CGSize(width: view.frame.width*0.85,
                   height: view.frame.height))
    
    let newView = RoundGamesCollectionView(
      frame: cvFrame, controller: self, round: round)
    
    newView.round = round
    
    return newView
  }
  
  
  // MARK: - View Helper Methods
  
  func getEmptyView() -> UIView {
    return ViewHelper.createEmptyView()
  }
  
  func getLabel() -> UILabel {
    let label = ViewHelper.createLabel(
      with: .white,
      text: "\(round.name)",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 28, weight: .semibold))
    
    return label
  }
  
  
  // MARK: - Dismiss Controller Button
  
  func createDismissButton() -> UIButton {
    let button = UIButton()
    
    button.setImage(
      UIImage(named: "Close_button_default"),
      for: .normal)
    
    button.setImage(
      UIImage(named: "Close_button_tapped"),
      for: .selected)
    
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
