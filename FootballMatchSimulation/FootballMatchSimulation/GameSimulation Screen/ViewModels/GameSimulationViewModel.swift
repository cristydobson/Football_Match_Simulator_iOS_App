///
/// GameSimulationViewModel.swift
///
/// The ViewModel for GameSimulationViewController
///
/// Created by Cristina Dobson
///


import Foundation


class GameSimulationViewModel {
  

  // MARK: - Methods
  
  // Load the HUD ViewModel
  func loadHudViewModel(for teams: [PlayingTeam]) -> HudViewModel {
    return HudViewModel(team1Name: teams[0].name,
                        team2Name: teams[1].name)
  }
  
  // Load the TeamView's ViewModel
  func loadTeamViewModel(for teams: [PlayingTeam]) -> TeamViewModel {
    return TeamViewModel(team1ImageName: teams[0].team.image_name,
                         team2ImageName: teams[1].team.image_name)
  }
  
}
