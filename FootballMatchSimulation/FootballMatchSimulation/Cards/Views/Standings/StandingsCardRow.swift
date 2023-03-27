///
/// StandingsCardRow.swift
///
/// Created by Cristina Dobson
///
///

import UIKit


class StandingsCardRow: UIView {

    
  // MARK: - Properties
  
  // Team Info Labels
  @IBOutlet weak var positionLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var teamLogo: UIImageView!
  
  // Matches Labels
  @IBOutlet weak var matchesLabel: UILabel!
  @IBOutlet weak var winsLabel: UILabel!
  @IBOutlet weak var drawsLabel: UILabel!
  @IBOutlet weak var losesLabel: UILabel!
  
  // Goals Labels
  @IBOutlet weak var goalsForLabel: UILabel!
  @IBOutlet weak var goalsAgainstLabel: UILabel!
  @IBOutlet weak var goalDifferenceLabel: UILabel!
  @IBOutlet weak var pointsLabel: UILabel!
  
  
  var viewModel: StandingsCardRowViewModel? {
    didSet {
      
      positionLabel.text = viewModel?.positionString
      nameLabel.text = viewModel?.team.shortened_name
      teamLogo.image = viewModel?.teamImage()
     
      // Total games played by the team
      matchesLabel.text = viewModel?.getString(for: .gamesPlayed)
      
      // Game Outcomes
      winsLabel.text = viewModel?.getString(for: .wins)
      drawsLabel.text = viewModel?.getString(for: .draws)
      losesLabel.text = viewModel?.getString(for: .losses)
      
      // Goals
      goalsForLabel.text = viewModel?.getString(for: .goalsFor)
      goalsAgainstLabel.text = viewModel?.getString(for: .goalsAgainst)
      goalDifferenceLabel.text = viewModel?.getString(for: .goalsDifference)
      
      // Points
      pointsLabel.text = viewModel?.getString(for: .points)
    }
  }
  
  
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
}
