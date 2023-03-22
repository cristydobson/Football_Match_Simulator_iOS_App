//
//  RoundCard.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/18/23.
//


import UIKit


class RoundCard: UIView {


  // MARK: - Properties
    
  // Header
  @IBOutlet weak var headerContainerView: UIView!
  @IBOutlet weak var separatorView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  
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
  
  func addViews() {
    
    row1 = UINib(nibName: "RoundCardRow", bundle: nil)
      .instantiate(withOwner: nil)[0] as? RoundCardRow
    row2 = UINib(nibName: "RoundCardRow", bundle: nil)
      .instantiate(withOwner: nil)[0] as? RoundCardRow
    
    [row1, row2].forEach {
      $0?.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0!)
    }
    
    
    NSLayoutConstraint.activate([
      row1.leadingAnchor.constraint(equalTo: leadingAnchor),
      row1.trailingAnchor.constraint(equalTo: trailingAnchor),
      row1.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: 12),
      row1.setHeightContraint(by: 50),
      
      row2.leadingAnchor.constraint(equalTo: leadingAnchor),
      row2.trailingAnchor.constraint(equalTo: trailingAnchor),
      row2.topAnchor.constraint(equalTo: row1.bottomAnchor, constant: 24),
      row2.setHeightContraint(by: 50)
    ])
    
  }

  func loadRows(withModels models: [RoundCardRowViewModel]?) {
    if let models = models {
      row1.viewModel = models[0]
      row2.viewModel = models[1]
    }
  }

  
}
