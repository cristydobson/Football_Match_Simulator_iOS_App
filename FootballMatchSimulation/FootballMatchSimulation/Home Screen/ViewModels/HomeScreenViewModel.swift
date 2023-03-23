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
  
  private var subscriptions = Set<AnyCancellable>()
  
  var teams: [Team] = [] {
    didSet {
      createTeamModels()
    }
  }
  
  @Published var teamModels: [TeamModel] = []
  
  @Published var rounds: [Round] = []
  
  
  
  // MARK: - Methods
  
  func loadTeams() {
    let fileName = JsonFileName.teams.rawValue
    
    if let teams = try? DataLoader.loadDataFromDirectory([Team].self, from: fileName) {
      self.teams = teams
    }
    else if let teams = try? DataLoader.loadDataFromBundle([Team].self, from: fileName) {
      self.teams = teams
      try! DataLoader.save(teams, to: fileName)
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
      name: team.name, shortenedName: team.shortened_name,
      id: team.id, stadium: team.stadium,
      imageName: team.image_name,
      keeper: team.keeper, defenders: team.defenders,
      midfielders: team.midfielders, attackers: team.attackers)
  }
  
  
  // MARK: - Load Rounds
  
  func generateRounds(_ models: [TeamModel]) -> [Round] {
    let generator = RoundGenerator()
    let newRounds = generator.getRounds(with: models)
    rounds = newRounds
    return newRounds
  }
  
  func loadRounds(with teamModels: [TeamModel]) {
    let fileName = JsonFileName.rounds.rawValue
    
    if let newRounds = try? DataLoader.loadDataFromDirectory([Round].self, from: fileName),
       newRounds.count > 0 {
      setupRoundBindings(for: newRounds)
      setupRounds(newRounds)
    }
    else if let newRounds = try? DataLoader.loadDataFromBundle([Round].self, from: fileName),
            newRounds.count > 0 {
      setupRoundBindings(for: newRounds)
      setupRounds(newRounds)
    }
    else {
      let newRounds = generateRounds(teamModels)
      setupRoundBindings(for: newRounds)
      try! DataLoader.save(newRounds, to: fileName)
    }
  }
  
  func setupRounds(_ roundModels: [Round]) {
    for round in roundModels {
      round.findTeamsForMatches(from: teamModels)
    }
    rounds = roundModels
  }
  
  func setupRoundBindings(for roundModels: [Round]) {
    for round in roundModels {
      setBinding(for: round)
    }
  }
  
  func setBinding(for round: Round) {
    
    for match in round.matches {
      match.$saveData.sink { [weak self] flag in
        if flag {
          print("SAVING ROUNDS!!!!!")
          self?.saveToDirectory((self?.rounds)!)
        }
      }
      .store(in: &subscriptions)
    }
  }
  
  func saveToDirectory(_ rounds: [Round]) {
    let fileName = JsonFileName.rounds.rawValue
    try! DataLoader.save(rounds, to: fileName)
  }
  
}
