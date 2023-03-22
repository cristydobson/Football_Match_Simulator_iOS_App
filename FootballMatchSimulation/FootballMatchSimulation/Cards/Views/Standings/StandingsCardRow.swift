//
//  StandingsCardRow.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/18/23.
//

import UIKit

class StandingsCardRow: UIView {

    
  // MARK: - Properties
  
  // Team Info Labels
  @IBOutlet weak var positionLabel: UILabel!
  @IBOutlet weak var teamLogo: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
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
  
  
  
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
  }
  
  
  
}
