//
//  HomeScreenViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/18/23.
//


import Foundation
import Combine


class HomeScreenViewModel: ObservableObject {
  
  
  // MARK: - Properties
  
  @Published var teams: [Team] = []
  
  
  
  // MARK: - Methods
  
  func loadTeams() {
    if let teams = try? DataLoader.retrieveData([Team].self, from: "Teams") {
      self.teams = teams
    }
  }
  
  
}
