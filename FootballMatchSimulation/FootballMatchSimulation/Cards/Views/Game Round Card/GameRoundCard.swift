///
/// GameRoundCard.swift
///
/// Created by Cristina Dobson
///


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
  
  // Scores
  @IBOutlet weak var scoresLabel: UILabel!
  
  // Play Button
  @IBOutlet weak var playButton: UIButton!
  
  
  var viewModel: GameRoundCardViewModel? {
    didSet {
      // Team 1
      team1NameLabel.text = viewModel?.teamName(at: 0)
      team1ImageView.image = viewModel?.teamImage(at: 0)
      
      // Team 2
      team2NameLabel.text = viewModel?.teamName(at: 1)
      team2ImageView.image = viewModel?.teamImage(at: 1)
      
      // Scores
      if let vm = viewModel, vm.match.gameIsPlayed {
        scoresLabel.text = viewModel?.teamsFinalScore()
      }
    }
  }
  
  
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupView()
    setupButton()
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    backgroundColor = .cardBackgroundColor
  }
  
  // Start the game button
  func setupButton() {
    playButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
    playButton.setTitle("START", for: .normal)
    playButton.backgroundColor = .cardYellowColor
    playButton.addCornerRadius(5)
  }
  
  
  // MARK: - Actions

  @IBAction func playButtonAction(_ sender: UIButton) {
    playButtonIsTapped = true
  }
  
}
