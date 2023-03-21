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
  
  
  
  
  
  // MARK: - Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addViews()
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
  

}
