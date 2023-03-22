//
//  RoundCardCell.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/21/23.
//


import UIKit
import Combine


class RoundCardCell: UICollectionViewCell {

  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  
  var roundCard: RoundCard!
  
  var viewModel: RoundCardCellViewModel? {
    didSet {
      roundCard.titleLabel.text = viewModel?.roundName
      roundCard.loadRows(withModels: viewModel?.games)
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
  
  
  // MARK: - Setup Methods
  
  func addViews() {
    
    roundCard = UINib(nibName: "RoundCard", bundle: nil)
      .instantiate(withOwner: nil)[0] as? RoundCard
    roundCard.translatesAutoresizingMaskIntoConstraints = false
    addSubview(roundCard)
    
    
    NSLayoutConstraint.activate([
      roundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      roundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      roundCard.topAnchor.constraint(equalTo: topAnchor, constant: 24),
      roundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
    ])
    
  }
  
  
  // MARK: - Bindings
  
  func setupBindings() {
    
    roundCard.$playButtonTapped.sink { [weak self] flag in
      if flag {
        self?.roundCard.playButtonTapped = false
        print("PRESENT ROUND VC!!!!!!")
      }
    }.store(in: &subscriptions)
    
  }
  

}
