//
//  StandingsView.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/24/23.
//


import Foundation
import UIKit


class StandingsView: UIView {
  
  
  // MARK: - Properties
  
  var standingsCard: StandingsCard!
  
  var viewModel: StandingsViewModel? {
    didSet {
      let cardViewModel = viewModel?.createCardViewModel()
      standingsCard.viewModel = cardViewModel
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
     Standings Card
     */
    standingsCard = UINib(nibName: "StandingsCard", bundle: nil)
      .instantiate(withOwner: nil)[0] as? StandingsCard
    standingsCard.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(standingsCard)
    
    
    NSLayoutConstraint.activate([
      standingsCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      standingsCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      standingsCard.topAnchor.constraint(equalTo: topAnchor),
      standingsCard.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
  }
  
  
  // MARK: - Helper Methods
  
  func updateStandings() {
    if let newTeams = viewModel?.updatedTeamStandings() {

      let cardViewModel = standingsCard.viewModel
      cardViewModel?.teams = newTeams
      standingsCard.viewModel = cardViewModel
    }
  }
  
}

