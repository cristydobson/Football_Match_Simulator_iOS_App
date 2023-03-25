//
//  RoundGameCell.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import UIKit
import Combine


class RoundGameCell: UICollectionViewCell, ObservableObject {
  
  
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
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cellTapped = false
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    addDropShadow()
    gameCard.addCornerRadius(5)
    gameCard.addBorderStyle(borderWidth: 1, borderColor: .alphaDarkBlue)
  }
  
  func addViews() {
    
    gameCard = getGameCard()
    addSubview(gameCard)
    
    NSLayoutConstraint.activate([
      gameCard.leadingAnchor.constraint(equalTo: leadingAnchor),
      gameCard.trailingAnchor.constraint(equalTo: trailingAnchor),
      gameCard.topAnchor.constraint(equalTo: topAnchor),
      gameCard.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
  }
  
  func getGameCard() -> GameRoundCard? {
    let card = UINib(nibName: "GameRoundCard", bundle: nil)
      .instantiate(withOwner: nil)[0] as? GameRoundCard
    
    card?.translatesAutoresizingMaskIntoConstraints = false
    
    return card
  }
  
  func addDropShadow() {
    addDropShadow(
      opacity: 0.5,
      radius: 4,
      offset: CGSize.zero,
      color: .darkBlue)
  }
  
  
  // MARK: - Bindings
  
  func setupBindings() {
    
    gameCard.$playButtonIsTapped.sink { [weak self] flag in
      if flag {
        DispatchQueue.main.async {
          self?.cellTapped = true
        }
      }
    }.store(in: &subscriptions)
    
  }
  
}
