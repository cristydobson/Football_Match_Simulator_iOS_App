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
  
  var teams: [Team] = [] {
    didSet {
      createTeamModels()
    }
  }
  
  @Published var teamModels: [TeamModel] = []
  
  @Published var rounds: [Round] = []
  
  
  
  // MARK: - Methods
  
  func loadTeams() {
    if let teams = try? DataLoader.retrieveData([Team].self, from: "Teams") {
      self.teams = teams
    }
  }
  
  func createTeamModels() {
    var models: [TeamModel] = []
    
    for team in teams {
      let model = buildTeamModel(from: team)
      models.append(model)
    }
    teamModels = models
  }
  
  func buildTeamModel(from team: Team) -> TeamModel {
    return TeamModel(
      name: team.name, stadium: team.stadium,
      imageName: team.image_name,
      keeper: team.keeper, defenders: team.defenders,
      midfielders: team.midfielders, attackers: team.attackers)
  }
  
  
  // MARK: - Load Rounds
  
  func generateRounds(_ models: [TeamModel]) {
    let generator = RoundGenerator()
    rounds = generator.getRounds(with: models)
  }
  
  
  
}
