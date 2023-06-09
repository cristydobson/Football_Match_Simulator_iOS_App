///
/// RoundCard.swift
///
/// Created by Cristina Dobson
///


import UIKit


class RoundCard: UIView {


  // MARK: - Properties
    
  // Header
  @IBOutlet weak var headerContainerView: UIView!
  @IBOutlet weak var separatorView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  
  // Rows in the card
  var row1: RoundCardRow!
  var row2: RoundCardRow!
  
  
  var viewModel: RoundCardViewModel? {
    didSet {
      titleLabel.text = viewModel?.title
      
      let rowViewModels = viewModel?.createRowViewModels()
      loadRows(withModels: rowViewModels)
    }
  }
  
      
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupView()
    addViews()
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    backgroundColor = .cardBackgroundColor
    separatorView.backgroundColor = .cardYellowColor
  }
  
  // Create the rows to display the matches
  func addViews() {
    
    row1 = createCardRow()
    row2 = createCardRow()
    
    addSubview(row1)
    addSubview(row2)
    
    
    NSLayoutConstraint.activate([
      
      row1.leadingAnchor.constraint(
        equalTo: leadingAnchor),
      row1.trailingAnchor.constraint(
        equalTo: trailingAnchor),
      row1.topAnchor.constraint(
        equalTo: headerContainerView.bottomAnchor, constant: 12),
      row1.setHeightContraint(by: 50),
      
      row2.leadingAnchor.constraint(
        equalTo: leadingAnchor),
      row2.trailingAnchor.constraint(
        equalTo: trailingAnchor),
      row2.topAnchor.constraint(
        equalTo: row1.bottomAnchor, constant: 12),
      row2.setHeightContraint(by: 50)
      
    ])
    
  }
  
  // Create a single card row
  func createCardRow() -> RoundCardRow? {
    let cardRow = UINib(nibName: "RoundCardRow", bundle: nil)
      .instantiate(withOwner: nil)[0] as? RoundCardRow
    
    cardRow?.translatesAutoresizingMaskIntoConstraints = false
    
    return cardRow
  }
  
  
  // MARK: Helper Methods

  // Load the rows with their ViewModels
  func loadRows(withModels models: [RoundCardRowViewModel]?) {
    if let models = models {
      row1.viewModel = models[0]
      row2.viewModel = models[1]
    }
  }

  
}
