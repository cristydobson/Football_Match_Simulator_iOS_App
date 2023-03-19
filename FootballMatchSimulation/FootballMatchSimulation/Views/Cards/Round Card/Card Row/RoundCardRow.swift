//
//  RoundCardRow.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/18/23.
//

import UIKit

class RoundCardRow: UIView {

  
  // MARK: - Properties
 
  // Team One
  @IBOutlet weak var teamOneNameLabel: UILabel!
  @IBOutlet weak var teamOneLogo: UIImageView!
  @IBOutlet weak var teamOneScoreLabel: UILabel!
  
  // Team Two
  @IBOutlet weak var teamTwoLogo: UIImageView!
  @IBOutlet weak var teamTwoNameLabel: UILabel!
  @IBOutlet weak var teamTwoScoreLabel: UILabel!
  
  
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
  }
  
  
  

}
