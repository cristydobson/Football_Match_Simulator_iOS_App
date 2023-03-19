//
//  FinalsCard.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/18/23.
//

import UIKit

class FinalsCard: UIView {

  
  // MARK: - Properties
  
  @IBOutlet weak var headerContainerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var playButton: UIButton!
  
  // Team One
  @IBOutlet weak var teamOneLogo: UIImageView!
  @IBOutlet weak var teamOneNameLabel: UILabel!
  @IBOutlet weak var teamOneScoreLabel: UILabel!
  
  // Team Two
  @IBOutlet weak var teamTwoLogo: UIImageView!
  @IBOutlet weak var teamTwoNameLabel: UILabel!
  @IBOutlet weak var teamTwoScoreLabel: UILabel!
  
  
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
  }
  
  
  
  
  // MARK: - Actions
  
  @IBAction func playButtonAction(_ sender: UIButton) {
  }
  

}
