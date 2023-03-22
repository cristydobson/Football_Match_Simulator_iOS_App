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
      let cardViewModel = viewModel?.createGameCardViewModel()
      gameCard.viewModel = cardViewModel
    }
  }
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addViews()
    setupView()
    
    setupBindings()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    gameCard.addCornerRadius(5)
    gameCard.addBorderStyle(borderWidth: 1, borderColor: .alphaDarkBlue)
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
