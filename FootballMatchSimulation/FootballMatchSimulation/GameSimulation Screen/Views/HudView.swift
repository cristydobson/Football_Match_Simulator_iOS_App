//
//  HudView.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/20/23.
//


import Foundation
import UIKit


class HudView: UIView {
  
  
  // MARK: - Properties
  
  var teamOneNameLabel: UILabel!
  var teamTwoNameLabel: UILabel!
  var playsCounter: UILabel!
  
  
  // MARK: - ViewModel
  
  var viewModel: HudViewModel? {
    didSet {
      teamOneNameLabel.text = viewModel?.team1Name
      teamTwoNameLabel.text = viewModel?.team2Name
    }
  }
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
  
  func addViews() {
    
    /*
     HUD Header Title One -->
     */
    // HUD Header Title One Container
    let hudHeaderTeamTitleOneContainer = ViewHelper.createEmptyView()
    addSubview(hudHeaderTeamTitleOneContainer)
    
    // HUD Header Title One Image
    let hudHeaderTeamTitleOne = ViewHelper.createImageView(contentMode: .scaleAspectFill)
    hudHeaderTeamTitleOne.image = UIImage(named: "Hud-Header-Team-Title-Right")
    hudHeaderTeamTitleOneContainer.addSubview(hudHeaderTeamTitleOne)
    
    // HUD Header Title One
    teamOneNameLabel = ViewHelper.createLabel(
      with: .white, text: "",
      alignment: .center, font: UIFont.systemFont(ofSize: 21, weight: .medium))
    hudHeaderTeamTitleOneContainer.addSubview(teamOneNameLabel)
    
    
    /*
     HUD Header Title Two -->
     */
    // HUD Header Title Two Container
    let hudHeaderTeamTitleTwoContainer = ViewHelper.createEmptyView()
    addSubview(hudHeaderTeamTitleTwoContainer)
    
    // HUD Header Title Two Image
    let hudHeaderTeamTitleTwo = ViewHelper.createImageView(contentMode: .scaleAspectFill)
    hudHeaderTeamTitleTwo.image = UIImage(named: "Hud-Header-Team-Title-Left")
    hudHeaderTeamTitleTwoContainer.addSubview(hudHeaderTeamTitleTwo)
    
    // HUD Header Title Two
    teamTwoNameLabel = ViewHelper.createLabel(
      with: .white, text: "",
      alignment: .center, font: UIFont.systemFont(ofSize: 21, weight: .medium))
    hudHeaderTeamTitleTwoContainer.addSubview(teamTwoNameLabel)
    
    
    /*
     HUD Header Plays Counter Label -->
     */
    playsCounter = ViewHelper.createLabel(
      with: .black, text: "0",
      alignment: .center, font: UIFont.systemFont(ofSize: 34, weight: .heavy))
    addSubview(playsCounter)
    
    
    /*
     HUD Stack View -->
     */
    let hudStackView = ViewHelper.createStackView(
      .horizontal, distribution: .fill)
    addSubview(hudStackView)
    
    hudStackView.addArrangedSubview(hudHeaderTeamTitleOneContainer)
    hudStackView.addArrangedSubview(playsCounter)
    hudStackView.addArrangedSubview(hudHeaderTeamTitleTwoContainer)
    
    
    NSLayoutConstraint.activate([
      
      // HUD Header Title Containers
      hudHeaderTeamTitleOneContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.42),
      hudHeaderTeamTitleTwoContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.42),
      
      /*
       HUD Header Title One
       */
      // HUD Header Title One Image
      hudHeaderTeamTitleOne.leadingAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.leadingAnchor),
      hudHeaderTeamTitleOne.trailingAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.trailingAnchor),
      hudHeaderTeamTitleOne.topAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.topAnchor),
      hudHeaderTeamTitleOne.bottomAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.bottomAnchor),
      
      // HUD Header Title One Label
      teamOneNameLabel.leadingAnchor.constraint(equalTo: hudHeaderTeamTitleOneContainer.leadingAnchor, constant: 36),
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
      teamTwoNameLabel.trailingAnchor.constraint(equalTo: hudHeaderTeamTitleTwoContainer.trailingAnchor, constant: -36),
      teamTwoNameLabel.topAnchor.constraint(equalTo: hudHeaderTeamTitleTwoContainer.topAnchor),
      teamTwoNameLabel.bottomAnchor.constraint(equalTo: hudHeaderTeamTitleTwoContainer.bottomAnchor),
      
      /*
       HUD Header Containers
       */
      // HUD Stack View
      hudStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      hudStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      hudStackView.topAnchor.constraint(equalTo: topAnchor),
      hudStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
  }
  
}












