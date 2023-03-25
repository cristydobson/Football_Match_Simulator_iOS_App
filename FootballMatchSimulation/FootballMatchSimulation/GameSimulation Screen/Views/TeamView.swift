//
//  TeamView.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/20/23.
//


import Foundation
import UIKit


class TeamView: UIView {
  
  
  // MARK: - Properties
  
  var team1ImageView: UIImageView!
  var team2ImageView: UIImageView!
  
  var team1ScoreLabel: UILabel!
  var team2ScoreLabel: UILabel!
  
  
  var viewModel: TeamViewModel? {
    didSet {
      let team1Logo = viewModel?.getTeamImage(viewModel!.team1ImageName)
      team1ImageView.image = team1Logo
      
      let team2Logo = viewModel?.getTeamImage(viewModel!.team2ImageName)
      team2ImageView.image = team2Logo
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
    
    // Team 1 Logo
    team1ImageView = getLogoImageView()
    addSubview(team1ImageView)
    
    
    // Team 2 Logo
    team2ImageView = getLogoImageView()
    addSubview(team2ImageView)
    
    
    // Team Score Container View
    let scoreView = getEmptyView()
    addSubview(scoreView)
    
    
    // Team 1 Score Label
    team1ScoreLabel = getScoreLabel("0")
    scoreView.addSubview(team1ScoreLabel)
    
    
    // Team 2 Score Label
    team2ScoreLabel = getScoreLabel("0")
    scoreView.addSubview(team2ScoreLabel)
    
    // Team Score Dash Label
    let dashLabel = getScoreLabel("-")
    scoreView.addSubview(dashLabel)
    
    
    // Team Score Labels StackView
    let teamScoreStackView = getStackView()
    teamScoreStackView.spacing = 4
    scoreView.addSubview(teamScoreStackView)
    
    teamScoreStackView.addArrangedSubview(team1ScoreLabel)
    teamScoreStackView.addArrangedSubview(dashLabel)
    teamScoreStackView.addArrangedSubview(team2ScoreLabel)
    
    
    // Container Stack View
    let containerStackView = getStackView()
    addSubview(containerStackView)
    
    containerStackView.addArrangedSubview(team1ImageView)
    containerStackView.addArrangedSubview(scoreView)
    containerStackView.addArrangedSubview(team2ImageView)
    
    
    NSLayoutConstraint.activate([
      
      // Logo Image Views
      team1ImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
      team1ImageView.widthAnchor.constraint(equalTo: team1ImageView.heightAnchor),
      team2ImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
      team2ImageView.widthAnchor.constraint(equalTo: team2ImageView.heightAnchor),
      
      // Team Score Stack View
      teamScoreStackView.centerXAnchor.constraint(equalTo: scoreView.centerXAnchor),
      teamScoreStackView.centerYAnchor.constraint(equalTo: scoreView.centerYAnchor),
      
      // Container Stack View
      containerStackView.topAnchor.constraint(equalTo: topAnchor),
      containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      containerStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
      containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
    
  }
  
  
  // MARK: - View Helper Methods
  
  func getLogoImageView() -> UIImageView {
    return ViewHelper.createImageView(contentMode: .scaleAspectFit)
  }
  
  func getEmptyView() -> UIView {
    return ViewHelper.createEmptyView()
  }
  
  func getScoreLabel(_ text: String) -> UILabel {
    let label = ViewHelper.createLabel(
      with: .black,
      text: text,
      alignment: .center,
      font: UIFont.systemFont(ofSize: 94, weight: .heavy))
    
    return label
  }
  
  func getStackView() -> UIStackView {
    return ViewHelper.createStackView(.horizontal, distribution: .fill)
  }
  
  
}
