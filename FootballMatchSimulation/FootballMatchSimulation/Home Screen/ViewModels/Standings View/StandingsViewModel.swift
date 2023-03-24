//
//  StandingsViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/24/23.
//


import Foundation


class StandingsViewModel {
  
  
  // MARK: - Properties
    
  let teamStandings = TeamStandings()
  
  let teams: [Team]
  
  
  // MARK: - Methods
  
  init(teams: [Team]) {
    self.teams = teams
  }
  
  func createCardViewModel() -> StandingsCardViewModel {
    let sortedTeams = TeamStandings.sortTeamsByStandings(teams)
    return StandingsCardViewModel(teams: sortedTeams)
  }
  
  func updatedTeamStandings() -> [Team] {
    let sortedTeams = TeamStandings.sortTeamsByStandings(teams)
    return sortedTeams
  }
  
  func updateTeamStandingsAfterReplay() {
    
  }
  
}
