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
  
  var viewModel: RoundCardRowViewModel? {
    didSet {
      // Team 1
      teamOneNameLabel.text = viewModel?.team1Name
      teamOneLogo.image = viewModel?.team1Logo
      teamOneScoreLabel.text = viewModel?.team1ScoreString
      
      // Team 2
      teamTwoNameLabel.text = viewModel?.team2Name
      teamTwoLogo.image = viewModel?.team2Logo
      teamTwoScoreLabel.text = viewModel?.team2ScoreString
    }
  }
  
  
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  
  

}
