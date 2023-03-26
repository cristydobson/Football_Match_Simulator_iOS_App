///
/// StandingsViewModel.swift
///
/// The view that Displays the StandingsCard.
///
///Created by Cristina Dobson
///


import Foundation


class StandingsViewModel {
  
  
  // MARK: - Properties
    
  let teams: [Team]
  
  
  // MARK: - Methods
  
  init(teams: [Team]) {
    self.teams = teams
  }
  
  // Create the ViewModel for the StandingsCard
  func createCardViewModel() -> StandingsCardViewModel {
    let sortedTeams = TeamStandings.sortTeamsByStandings(teams)
    return StandingsCardViewModel(teams: sortedTeams)
  }
  
  /*
   Sort the teams by standings before
   handing them over to the StandingsCard
   */
  func sortTeamsByStandings() -> [Team] {
    let sortedTeams = TeamStandings.sortTeamsByStandings(teams)
    return sortedTeams
  }
  
}
