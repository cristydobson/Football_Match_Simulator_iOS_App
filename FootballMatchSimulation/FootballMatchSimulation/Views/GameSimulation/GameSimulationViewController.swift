//
//  GameSimulationViewController.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation
import UIKit


class GameSimulationViewController: UIViewController {
  
  
  // MARK: - Properties
  
  var hudContainerView: UIView!
  var playsCounter: UILabel!
  
  var teamsContainerView: UIView!
  
  var updatesLabel: UILabel!
  
  
  
  
  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    transitionToLandscape()
    
    
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupBackground()
    addViews()
  }
  
  
  // MARK: - Swetup Methods
  
  func transitionToLandscape() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.appOrientation = .landscape
  }
  
  func setupBackground() {
    view.addGradientBackground()
  }
  
  func addViews() {
    
    let safeArea = view.safeAreaLayoutGuide

    /*
     HUD
     */
    hudContainerView = ViewHelper.createEmptyView()
    hudContainerView.backgroundColor = .white
    view.addSubview(hudContainerView)
    
    playsCounter = ViewHelper.createLabel(
      with: .black, text: "0",
      alignment: .center, font: UIFont.systemFont(ofSize: 34, weight: .heavy))
    hudContainerView.addSubview(playsCounter)
    
    NSLayoutConstraint.activate([
      
      // Plays Counter Label
      playsCounter.topAnchor.constraint(greaterThanOrEqualTo: hudContainerView.topAnchor, constant: 0),
      playsCounter.bottomAnchor.constraint(equalTo: hudContainerView.bottomAnchor, constant: -8),
      playsCounter.centerXAnchor.constraint(equalTo: hudContainerView.centerXAnchor),
      
      // Container View
      hudContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 100),
      hudContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -100),
      hudContainerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
      hudContainerView.setHeightContraint(by: 50)
    ])
    
    
    /*
     TeamsContainerView
     */
    teamsContainerView = ViewHelper.createEmptyView()
    teamsContainerView.backgroundColor = .white
    view.addSubview(teamsContainerView)
    
    NSLayoutConstraint.activate([
      teamsContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 100),
      teamsContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -100),
      teamsContainerView.topAnchor.constraint(equalTo: hudContainerView.bottomAnchor, constant: 24),
      teamsContainerView.setHeightContraint(by: 200)
    ])
    
    
    /*
     Updates Label
     */
    
    updatesLabel = ViewHelper.createLabel(
      with: .black, text: "Game is starting...",
      alignment: .center, font: UIFont.systemFont(ofSize: 24, weight: .medium))
    view.addSubview(updatesLabel)
    
    NSLayoutConstraint.activate([
      updatesLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeArea.leadingAnchor, constant: 24),
      updatesLabel.trailingAnchor.constraint(greaterThanOrEqualTo: safeArea.trailingAnchor, constant: -24),
      updatesLabel.topAnchor.constraint(equalTo: teamsContainerView.bottomAnchor, constant: 24),
      updatesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    
  }
  
  
  
  
  
}








