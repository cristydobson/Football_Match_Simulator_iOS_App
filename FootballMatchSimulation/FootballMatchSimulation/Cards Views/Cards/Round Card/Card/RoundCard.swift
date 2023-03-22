//
//  RoundCard.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/18/23.
//


import UIKit
import Combine


class RoundCard: UIView, ObservableObject {


  // MARK: - Properties
  
  @Published var playButtonTapped = false
  
  // Header
  @IBOutlet weak var headerContainerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var playButton: UIButton!
  
  var row1: RoundCardRow!
  var row2: RoundCardRow!
  
  
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    addViews()
  }
  
  
  // MARK: - Setup Methods
  
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
      row1.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
      row1.setHeightContraint(by: 50),
      
      row2.leadingAnchor.constraint(equalTo: leadingAnchor),
      row2.trailingAnchor.constraint(equalTo: trailingAnchor),
      row2.topAnchor.constraint(equalTo: row1.bottomAnchor),
      row2.setHeightContraint(by: 50)
    ])
    
  }
  
  func loadRows(withModels models: [RoundCardRowViewModel]?) {
    if let models = models {
      row1.viewModel = models[0]
      row2.viewModel = models[1]
    }
  }
  
  
  
  // MARK: - Actions
  
  @IBAction func playButtonAction(_ sender: UIButton) {
    playButtonTapped = true
  }
  
  
  
  
}
