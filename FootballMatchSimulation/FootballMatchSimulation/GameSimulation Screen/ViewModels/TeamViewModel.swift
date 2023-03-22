//
//  TeamViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/20/23.
//


import Foundation
import UIKit


class TeamViewModel {
  
  
  // MARK: - Properties
  
  let team1ImageName: String
  let team2ImageName: String
  
  
  // MARK: - Methods
  
  init(team1ImageName: String, team2ImageName: String) {
    self.team1ImageName = team1ImageName
    self.team2ImageName = team2ImageName
  }
  
  func getTeamImage(_ name: String) -> UIImage? {
    return ImageHelper.getImage(name)
  }
  
}
