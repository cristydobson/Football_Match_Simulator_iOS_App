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
    
    /*
     Team 1 Logo
     */
    team1ImageView = ViewHelper.createImageView(contentMode: .scaleAspectFit)
    addSubview(team1ImageView)
    
    
    /*
     Team 2 Logo
     */
    team2ImageView = ViewHelper.createImageView(contentMode: .scaleAspectFit)
    addSubview(team2ImageView)
    
    
    /*
     Team Score Container View
     */
    let scoreView = ViewHelper.createEmptyView()
    addSubview(scoreView)
    
    
    /*
     Team 1 Score Label
     */
    team1ScoreLabel = ViewHelper.createLabel(
      with: .black, text: "0",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 94, weight: .heavy))
    scoreView.addSubview(team1ScoreLabel)
    
    
    /*
     Team 2 Score Label
     */
    team2ScoreLabel = ViewHelper.createLabel(
      with: .black, text: "0",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 94, weight: .heavy))
    scoreView.addSubview(team2ScoreLabel)
    
    /*
     Team Score Dash Label
     */
    let dashLabel = ViewHelper.createLabel(
      with: .black, text: "-",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 94, weight: .heavy))
    scoreView.addSubview(dashLabel)
    
    
    /*
     Team Score Labels StackView
     */
    let teamScoreStackView = ViewHelper.createStackView(
      .horizontal, distribution: .fill)
    teamScoreStackView.spacing = 4
    scoreView.addSubview(teamScoreStackView)
    
    teamScoreStackView.addArrangedSubview(team1ScoreLabel)
    teamScoreStackView.addArrangedSubview(dashLabel)
    teamScoreStackView.addArrangedSubview(team2ScoreLabel)
    
    
    /*
     Container Stack View
     */
    let containerStackView = ViewHelper.createStackView(
      .horizontal, distribution: .fill)
    addSubview(containerStackView)
    
    containerStackView.addArrangedSubview(team1ImageView)
    containerStackView.addArrangedSubview(scoreView)
    containerStackView.addArrangedSubview(team2ImageView)
    
    
    NSLayoutConstraint.activate([
      
      // Logo Image Views
      team1ImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
      team1ImageView.heightAnchor.constraint(equalTo: team1ImageView.widthAnchor),
      team2ImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
      team2ImageView.heightAnchor.constraint(equalTo: team2ImageView.widthAnchor),
      
      // Team Score Stack View
      teamScoreStackView.centerXAnchor.constraint(equalTo: scoreView.centerXAnchor),
      teamScoreStackView.centerYAnchor.constraint(equalTo: scoreView.centerYAnchor),
      
      // Container Stack View
      containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerStackView.topAnchor.constraint(equalTo: topAnchor),
      containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
  }
  
  
  
  
}
