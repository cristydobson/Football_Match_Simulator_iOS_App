///
/// RoundCardCell.swift
///
/// Cell for every Round
///
/// Created by Cristina Dobson
///


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
    addDropShadow()
    roundCard.addCornerRadius(5)
    roundCard.addBorderStyle(
      borderWidth: 1, borderColor: .alphaDarkBlue)
  }
  
  /*
   Add the Round card displaying
   the matches in the round
   */
  func addViews() {
    
    roundCard = getRoundCard()
    addSubview(roundCard)

    NSLayoutConstraint.activate([
      roundCard.leadingAnchor.constraint(equalTo: leadingAnchor),
      roundCard.trailingAnchor.constraint(equalTo: trailingAnchor),
      roundCard.topAnchor.constraint(equalTo: topAnchor),
      roundCard.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
  }
  
  // Get Round card
  func getRoundCard() -> RoundCard? {
    let card = UINib(nibName: "RoundCard", bundle: nil)
      .instantiate(withOwner: nil)[0] as? RoundCard
    
    card?.translatesAutoresizingMaskIntoConstraints = false
    
    return card
  }
  
  func addDropShadow() {
    addDropShadow(
      opacity: 0.5,
      radius: 8,
      offset: CGSize.zero,
      color: .darkBlue)
  }

}
