//
//  GameSimulationViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/20/23.
//


import Foundation


class GameSimulationViewModel {
  
  
  // MARK: - Properties
  
    
  
  // MARK: - Methods
  
  func loadHudViewModel(for teams: [PlayingTeam]) -> HudViewModel {
    return HudViewModel(team1Name: teams[0].name,
                        team2Name: teams[1].name)
  }
  
  func loadTeamViewModel(for teams: [PlayingTeam]) -> TeamViewModel {
    return TeamViewModel(team1ImageName: teams[0].team.imageName,
                         team2ImageName: teams[1].team.imageName)
  }
  
  
}
