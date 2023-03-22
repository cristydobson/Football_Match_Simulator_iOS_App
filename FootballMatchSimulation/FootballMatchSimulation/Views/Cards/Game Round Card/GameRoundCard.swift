//
//  GameRoundCard.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/18/23.
//


import UIKit
import Combine


class GameRoundCard: UIView, ObservableObject {

  
  // MARK: - Properties
  
  @Published var playButtonIsTapped: Bool = false
  
  @IBOutlet weak var titleLabel: UILabel!
  
  // Team 1
  @IBOutlet weak var team1ImageView: UIImageView!
  @IBOutlet weak var team1NameLabel: UILabel!
  
  // Team 2
  @IBOutlet weak var team2ImageView: UIImageView!
  @IBOutlet weak var team2NameLabel: UILabel!
  
  // Play Button
  @IBOutlet weak var playButton: UIButton!
  
  
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
  }
  
  
  
  
  // MARK: - Actions

  @IBAction func playButtonAction(_ sender: UIButton) {
    playButtonIsTapped = true
  }
  

}
