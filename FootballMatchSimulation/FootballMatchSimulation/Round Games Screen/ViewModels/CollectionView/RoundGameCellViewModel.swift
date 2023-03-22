//
//  RoundGameCellViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import UIKit


class RoundGameCellViewModel {
  
  
  // MARK: - Properties
  
  let team1Name: String
  let team1ImageName: String
  var team1Logo: UIImage? {
    return getTeamImage(for: team1ImageName)
  }
  
  let team2Name: String
  let team2ImageName: String
  var team2Logo: UIImage? {
    return getTeamImage(for: team2ImageName)
  }
  
  
  // MARK: - Methods
  
  init(team1Name: String, team1ImageName: String, team2Name: String, team2ImageName: String) {
    self.team1Name = team1Name
    self.team1ImageName = team1ImageName
    self.team2Name = team2Name
    self.team2ImageName = team2ImageName
  }
  
  func getTeamImage(for name: String) -> UIImage? {
    return ImageHelper.getImage(name)
  }
  
}
