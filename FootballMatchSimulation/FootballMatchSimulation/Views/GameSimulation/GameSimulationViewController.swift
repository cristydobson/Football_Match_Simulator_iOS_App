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
  var teamOneNameLabel: UILabel!
  var teamTwoNameLabel: UILabel!
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
     HUD View Container
     */
    hudContainerView = ViewHelper.createEmptyView()
    view.addSubview(hudContainerView)
    
    /*
     HUD Header Title One -->
     */
    // HUD Header Title One Container
    let hudHeaderTeamTitleOneContainer = ViewHelper.createEmptyView()
    hudContainerView.addSubview(hudHeaderTeamTitleOneContainer)
    
    // HUD Header Title One Image
    let hudHeaderTeamTitleOne = ViewHelper.createImageView(contentMode: .scaleAspectFill)
    hudHeaderTeamTitleOne.image = UIImage(named: "Hud-Header-Team-Title-Right")
    hudHeaderTeamTitleOneContainer.addSubview(hudHeaderTeamTitleOne)
    
    // HUD Header Title One
    teamOneNameLabel = ViewHelper.createLabel(
      with: .white, text: "FC Barcelona",
      alignment: .left, font: UIFont.systemFont(ofSize: 20, weight: .medium))
    hudHeaderTeamTitleOneContainer.addSubview(teamOneNameLabel)
   
    /*
     HUD Header Title Two -->
     */
    // HUD Header Title Two Container
    let hudHeaderTeamTitleTwoContainer = ViewHelper.createEmptyView()
    hudContainerView.addSubview(hudHeaderTeamTitleTwoContainer)
    
    // HUD Header Title Two Image
    let hudHeaderTeamTitleTwo = ViewHelper.createImageView(contentMode: .scaleAspectFill)
    hudHeaderTeamTitleTwo.image = UIImage(named: "Hud-Header-Team-Title-Left")
    hudHeaderTeamTitleTwoContainer.addSubview(hudHeaderTeamTitleTwo)
    
    // HUD Header Title Two
    teamTwoNameLabel = ViewHelper.createLabel(
      with: .white, text: "Paris Saint Germain",
      alignment: .left, font: UIFont.systemFont(ofSize: 20, weight: .medium))
    hudHeaderTeamTitleTwoContainer.addSubview(teamTwoNameLabel)
    
    /*
     HUD Header Plays Counter Label -->
     */
    playsCounter = ViewHelper.createLabel(
      with: .black, text: "0",
      alignment: .center, font: UIFont.systemFont(ofSize: 34, weight: .heavy))
    hudContainerView.addSubview(playsCounter)
    
    /*
     HUD Stack View -->
     */
    let hudStackView = ViewHelper.createStackView(
      .horizontal, distribution: .fill)
    hudContainerView.addSubview(hudStackView)
    
    hudStackView.addArrangedSubview(hudHeaderTeamTitleOneContainer)
    hudStackView.addArrangedSubview(playsCounter)
    hudStackView.addArrangedSubview(hudHeaderTeamTitleTwoContainer)
    
    
    NSLayoutConstraint.activate([
      
      // HUD Header Title Containers
      hudHeaderTeamTitleOneContainer.widthAnchor.constraint(equalTo: hudContainerView.widthAnchor, multiplier: 0.42),
      hudHeaderTeamTitleTwoContainer.widthAnchor.constraint(equalTo: hudContainerView.widthAnchor, multiplier: 0.42),
      
      /*
       HUD Header Title One
       */
      // HUD Header Title One Image
      hudHeaderTeamTitleOne.leadingAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.leadingAnchor),
      hudHeaderTeamTitleOne.trailingAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.trailingAnchor),
      hudHeaderTeamTitleOne.topAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.topAnchor),
      hudHeaderTeamTitleOne.bottomAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.bottomAnchor),
      
      // HUD Header Title One Label
      teamOneNameLabel.leadingAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.leadingAnchor, constant: 24),
      teamOneNameLabel.topAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.topAnchor),
      teamOneNameLabel.bottomAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.bottomAnchor),
      
      /*
       HUD Header Title Two
       */
      // HUD Header Title Two Image
      hudHeaderTeamTitleTwo.leadingAnchor.constraint(equalTo: hudHeaderTeamTitleTwoContainer.leadingAnchor),
      hudHeaderTeamTitleTwo.trailingAnchor.constraint(equalTo: hudHeaderTeamTitleTwoContainer.trailingAnchor),
      hudHeaderTeamTitleTwo.topAnchor.constraint(equalTo: hudHeaderTeamTitleTwoContainer.topAnchor),
      hudHeaderTeamTitleTwo.bottomAnchor.constraint(equalTo: hudHeaderTeamTitleTwoContainer.bottomAnchor),
      
      // HUD Header Title One Label
      teamTwoNameLabel.trailingAnchor.constraint(equalTo: hudHeaderTeamTitleTwoContainer.trailingAnchor, constant: -24),
      teamTwoNameLabel.topAnchor.constraint(equalTo: hudHeaderTeamTitleTwoContainer.topAnchor),
      teamTwoNameLabel.bottomAnchor.constraint(equalTo: hudHeaderTeamTitleTwoContainer.bottomAnchor),
      
      /*
       HUD Header Containers
       */
      // HUD Stack View
      hudStackView.leadingAnchor.constraint(equalTo: hudContainerView.leadingAnchor),
      hudStackView.trailingAnchor.constraint(equalTo: hudContainerView.trailingAnchor),
      hudStackView.topAnchor.constraint(equalTo: hudContainerView.topAnchor),
      hudStackView.bottomAnchor.constraint(equalTo: hudContainerView.bottomAnchor),
      
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








