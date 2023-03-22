//
//  RoundGameCell.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import UIKit
import Combine


class RoundGameCell: UICollectionViewCell {
  
  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  
  @Published var cellTapped = false
  
  var gameCard: GameRoundCard!
  
  
  var viewModel: RoundGameCellViewModel? {
    didSet {
      gameCard.team1NameLabel.text = viewModel?.team1Name
      gameCard.team1ImageView.image = viewModel?.team1Logo
      
      gameCard.team2NameLabel.text = viewModel?.team2Name
      gameCard.team2ImageView.image = viewModel?.team2Logo
    }
  }
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addViews()
    
    setupBindings()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func addViews() {
    
    gameCard = UINib(nibName: "GameRoundCard", bundle: nil)
      .instantiate(withOwner: nil)[0] as? GameRoundCard
    gameCard.translatesAutoresizingMaskIntoConstraints = false
    addSubview(gameCard)
    
    NSLayoutConstraint.activate([
      gameCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      gameCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      gameCard.topAnchor.constraint(equalTo: topAnchor, constant: 24),
      gameCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
    ])
    
    
  }
  
  
  // MARK: - Bindings
  
  func setupBindings() {
    
    gameCard.$playButtonIsTapped.sink { [weak self] flag in
      DispatchQueue.main.async {
        if flag {
          self?.cellTapped = true
        }
      }
    }.store(in: &subscriptions)
    
  }
  
  
  
}
