//
//  RoundCardRowViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import UIKit


class RoundCardRowViewModel {
  
  
  // MARK: - Properties
  
  // Team 1
  let team1Name: String
  let team1ImageName: String
  var team1Score: Int = 0
  
  var team1Logo: UIImage? {
    return getTeamImage(for: team1ImageName)
  }
  
  var team1ScoreString: String {
    return "\(team1Score)"
  }
  
  // Team 2
  let team2Name: String
  let team2ImageName: String
  var team2Score: Int = 0
  
  var team2Logo: UIImage? {
    return getTeamImage(for: team2ImageName)
  }
  
  var team2ScoreString: String {
    return "\(team2Score)"
  }
  
  
  // MARK: Methods
  
  init(team1Name: String, team1ImageName: String, team1Score: Int, team2Name: String, team2ImageName: String, team2Score: Int) {
    self.team1Name = team1Name
    self.team1ImageName = team1ImageName
    self.team1Score = team1Score
    self.team2Name = team2Name
    self.team2ImageName = team2ImageName
    self.team2Score = team2Score
  }
  
  
  // MARK: - Method Helpers
  
  func getTeamImage(for name: String) -> UIImage? {
    return ImageHelper.getImage(name)
  }
  
  
}
