//
//  GameSimulationViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/20/23.
//


import Foundation
import Combine


class GameSimulationViewModel: ObservableObject {
  
  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  @Published private(set) var currentEvent: String = ""
    
  
  // MARK: - Methods
  
  func loadHudViewModel(for teams: [PlayingTeam]) -> HudViewModel {
    return HudViewModel(team1Name: teams[0].name,
                        team2Name: teams[1].name)
  }
  
  func loadTeamViewModel(for teams: [PlayingTeam]) -> TeamViewModel {
    return TeamViewModel(team1ImageName: teams[0].team.image_name,
                         team2ImageName: teams[1].team.image_name)
  }
  
  
}
