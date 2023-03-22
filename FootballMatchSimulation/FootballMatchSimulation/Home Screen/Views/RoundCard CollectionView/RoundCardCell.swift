//
//  RoundCardCell.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/21/23.
//


import UIKit


class RoundCardCell: UICollectionViewCell {

  
  // MARK: - Properties
    
  var roundCard: RoundCard!
  
  var viewModel: RoundCardCellViewModel? {
    didSet {
      let cardViewModel = viewModel?.createRoundCardViewModel()
      roundCard.viewModel = cardViewModel
    }
  }
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addViews()
    setupView()
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    roundCard.addCornerRadius(5)
    roundCard.addBorderStyle(borderWidth: 1, borderColor: .alphaDarkBlue)
  }
  
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


}
