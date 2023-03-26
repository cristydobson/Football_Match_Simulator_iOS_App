//
//  StandingsCard.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/18/23.
//

import UIKit

class StandingsCard: UIView {

   
  // MARK: - Properties
  
  @IBOutlet weak var headerStackView: UIStackView!
  
  var row1: StandingsCardRow!
  var row2: StandingsCardRow!
  var row3: StandingsCardRow!
  var row4: StandingsCardRow!
  
  
  var viewModel: StandingsCardViewModel? {
    didSet {
      loadRows()
    }
  }
  

  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    addViews()
  }
  

  
  func addViews() {
    
    row1 = createCardRow()
    row2 = createCardRow()
    row3 = createCardRow()
    row4 = createCardRow()
    
    let rows = [row1, row2, row3, row4]
    
    rows.forEach {
      addSubview($0!)
    }
    
    
    NSLayoutConstraint.activate([
      row1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      row1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      row1.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 16),
      
      row2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      row2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      row2.topAnchor.constraint(equalTo: row1.bottomAnchor, constant: 8),
      
      row3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      row3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      row3.topAnchor.constraint(equalTo: row2.bottomAnchor, constant: 8),
      
      row4.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      row4.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      row4.topAnchor.constraint(equalTo: row3.bottomAnchor, constant: 8)
    ])
    
  }
  
  func createCardRow() -> StandingsCardRow? {
    let cardRow = UINib(nibName: "StandingsCardRow", bundle: nil)
      .instantiate(withOwner: nil)[0] as? StandingsCardRow
    
    cardRow?.translatesAutoresizingMaskIntoConstraints = false
    
    return cardRow
  }
  
  
  // MARK: - Load Rows
  
  func loadRows() {
    
    let rowViewModels = viewModel?.loadRowViewModels()
    let rows = [row1, row2, row3, row4]
    
    for i in 0..<rows.count {
      rows[i]?.viewModel = rowViewModels![i]
    }
  }
  
}
