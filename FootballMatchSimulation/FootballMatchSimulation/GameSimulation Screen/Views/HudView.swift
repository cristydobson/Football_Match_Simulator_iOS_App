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
    
    // Title One Container
    let hudHeaderTeamTitleOneContainer = getEmptyView()
    addSubview(hudHeaderTeamTitleOneContainer)
    
    setLeftTitleView(on: hudHeaderTeamTitleOneContainer)
    
    
    // Title Two Container
    let hudHeaderTeamTitleTwoContainer = getEmptyView()
    addSubview(hudHeaderTeamTitleTwoContainer)
    
    setRightTitleView(on: hudHeaderTeamTitleTwoContainer)
    
    
    // Plays Counter Label
    playsCounter = getPlaysCounterLabel()
    addSubview(playsCounter)
    
    
    // Container Stack View
    let hudStackView = getStackView()
    addSubview(hudStackView)
    
    hudStackView.addArrangedSubview(hudHeaderTeamTitleOneContainer)
    hudStackView.addArrangedSubview(playsCounter)
    hudStackView.addArrangedSubview(hudHeaderTeamTitleTwoContainer)
    
    
    NSLayoutConstraint.activate([
      
      // Header Title Containers
      hudHeaderTeamTitleOneContainer.widthAnchor.constraint(
        equalTo: widthAnchor, multiplier: 0.42),
      hudHeaderTeamTitleTwoContainer.widthAnchor.constraint(
        equalTo: widthAnchor, multiplier: 0.42),
      
      // Container Stack View
      hudStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      hudStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      hudStackView.topAnchor.constraint(equalTo: topAnchor),
      hudStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
  }
  
  
  func setLeftTitleView(on container: UIView) {
    
    // HUD Header Title One Image
    let titleHeaderBackgroundView = getImageView(
      for: "Hud-Header-Team-Title-Right")
    container.addSubview(titleHeaderBackgroundView)
    
    // HUD Header Title One
    teamOneNameLabel = getTeamLabel()
    container.addSubview(teamOneNameLabel)
    
    
    NSLayoutConstraint.activate([
      
      // HUD Header Title One Image
      titleHeaderBackgroundView.leadingAnchor.constraint(
        equalTo: container.leadingAnchor),
      titleHeaderBackgroundView.trailingAnchor.constraint(
        equalTo: container.trailingAnchor),
      titleHeaderBackgroundView.topAnchor.constraint(
        equalTo: container.topAnchor),
      titleHeaderBackgroundView.bottomAnchor.constraint(
        equalTo: container.bottomAnchor),
      
      // HUD Header Title One Label
      teamOneNameLabel.leadingAnchor.constraint(
        equalTo: container.leadingAnchor, constant: 36),
      teamOneNameLabel.topAnchor.constraint(
        equalTo: container.topAnchor),
      teamOneNameLabel.bottomAnchor.constraint(
        equalTo: container.bottomAnchor)
    ])
    
  }
  
  func setRightTitleView(on container: UIView) {
    
    // HUD Header Title Two Image
    let titleHeaderBackgroundView = getImageView(
      for: "Hud-Header-Team-Title-Left")
    container.addSubview(titleHeaderBackgroundView)
    
    // HUD Header Title Two
    teamTwoNameLabel = getTeamLabel()
    container.addSubview(teamTwoNameLabel)
    
    
    NSLayoutConstraint.activate([
      
      // HUD Header Title Two Image
      titleHeaderBackgroundView.leadingAnchor.constraint(
        equalTo: container.leadingAnchor),
      titleHeaderBackgroundView.trailingAnchor.constraint(
        equalTo: container.trailingAnchor),
      titleHeaderBackgroundView.topAnchor.constraint(
        equalTo: container.topAnchor),
      titleHeaderBackgroundView.bottomAnchor.constraint(
        equalTo: container.bottomAnchor),
      
      // HUD Header Title One Label
      teamTwoNameLabel.trailingAnchor.constraint(
        equalTo: container.trailingAnchor, constant: -36),
      teamTwoNameLabel.topAnchor.constraint(
        equalTo: container.topAnchor),
      teamTwoNameLabel.bottomAnchor.constraint(
        equalTo: container.bottomAnchor)
    ])
    
  }
  
  
  
  // MARK: - View Helper Methods
  
  func getEmptyView() -> UIView {
    return ViewHelper.createEmptyView()
  }
  
  func getImageView(for image: String) -> UIImageView {
    let imageView = ViewHelper.createImageView(
      contentMode: .scaleAspectFill)
    imageView.image = UIImage(named: image)
    
    return imageView
  }
  
  func getTeamLabel() -> UILabel {
    let label = ViewHelper.createLabel(
      with: .white,
      text: "",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 21, weight: .medium))
    
    return label
  }
  
  func getPlaysCounterLabel() -> UILabel {
    let label = ViewHelper.createLabel(
      with: .black,
      text: "0",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 34, weight: .heavy))
    
    return label
  }
  
  func getStackView() -> UIStackView {
    return ViewHelper.createStackView(
      .horizontal, distribution: .fill)
  }
  
}












