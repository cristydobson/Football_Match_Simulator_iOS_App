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
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var playButton: UIButton!
  
  
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
  }
  
  
  // MARK: - Actions
  
  @IBAction func playButtonAction(_ sender: UIButton) {
  }
  
  
  
}
