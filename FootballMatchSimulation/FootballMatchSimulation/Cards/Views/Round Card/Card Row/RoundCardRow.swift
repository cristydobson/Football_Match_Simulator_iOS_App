///
/// RoundCardRow.swift
///
/// Created by Cristina Dobson
/// 

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
      
      let scoreLabelColor = viewModel?.scoreLabelColor()
      
      // Team 1
      teamOneNameLabel.text = viewModel?.teamName(at: 0)
      teamOneLogo.image = viewModel?.teamImage(at: 0)
      teamOneScoreLabel.text = viewModel?.teamScore(at: 0)
      teamOneScoreLabel.textColor = scoreLabelColor
      
      // Team 2
      teamTwoNameLabel.text = viewModel?.teamName(at: 1)
      teamTwoLogo.image = viewModel?.teamImage(at: 1)
      teamTwoScoreLabel.text = viewModel?.teamScore(at: 1)
      teamTwoScoreLabel.textColor = scoreLabelColor
      
    }
  }
  
  
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
}
