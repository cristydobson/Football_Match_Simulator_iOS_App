///
/// HudViewModel.swift
///
/// The ViewModel for HudView.
///
/// Created by Cristina Dobson
///


import Foundation


class HudViewModel {
  
  
  // MARK: - Properties
  
  let team1Name: String
  let team2Name: String
  var plays = 0
  
  
  // MARK: - Methods

  init(team1Name: String, team2Name: String) {
    self.team1Name = team1Name
    self.team2Name = team2Name
  }
  
  // Get the names of the teams playing
  func getNameCapitalized(at index: Int) -> String {
    let string = index == 0 ? team1Name : team2Name
    return string.uppercased()
  }
  
}












