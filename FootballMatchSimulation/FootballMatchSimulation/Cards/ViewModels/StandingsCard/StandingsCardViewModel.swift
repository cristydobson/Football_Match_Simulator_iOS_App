///
/// StandingsCardViewModel.swift
///
/// Created by Cristina Dobson
///


import Foundation


class StandingsCardViewModel {
  
  
  // MARK: - Properties
  
  var teams: [Team]
  
  var rowModels: [StandingsCardRowViewModel] = []
  
  
  // MARK: - Methods
  
  init(teams: [Team]) {
    self.teams = teams
  }
  
  /*
   Load the view models for every row
   in the Standings board
   */
  func loadRowViewModels() -> [StandingsCardRowViewModel] {
    return createRowViewModels()
  }
  
  
  func createRowViewModels() -> [StandingsCardRowViewModel] {
    var viewModels: [StandingsCardRowViewModel] = []
    
    for i in 0..<teams.count {
      let team = teams[i]
      
      let viewModel = buildRowViewModel(from: team, at: i+1)
      viewModels.append(viewModel)
    }
    return viewModels
  }
  
  
  func buildRowViewModel(from team: Team, at index: Int) -> StandingsCardRowViewModel {
    return StandingsCardRowViewModel(team: team, position: index)
  }
  
  
}
