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
  
  @Published var rounds: [Round] = []
  
  @Published var teams: [Team] = []
  
  @Published var standingsViewModel: StandingsViewModel!
  
  @Published var updateStandings = false
  
  
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
  
  
  // MARK: - Load Rounds
  
  func generateRounds(_ models: [Team]) -> [Round] {
    let generator = RoundGenerator()
    let newRounds = generator.getRounds(with: models)
    rounds = newRounds
    return newRounds
  }
  
  func loadRounds(with teamModels: [Team]) {
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
      round.findTeamsForMatches(from: teams)
    }
    rounds = roundModels
  }
  
  func setupRoundBindings(for roundModels: [Round]) {
    for round in roundModels {
      setBindings(for: round)
    }
  }
  
  func setBindings(for round: Round) {
    
    for match in round.matches {
      
      match.$saveRounds.sink { [weak self] flag in
        if flag {
          DispatchQueue.main.async {
            self?.saveRounds()
          }
        }
      }.store(in: &subscriptions)
      
      match.$saveTeams.sink { [weak self] flag in
        if flag {
          DispatchQueue.main.async {
            self?.saveTeams()
          }
        }
      }.store(in: &subscriptions)
      
      match.$didReplayGame.sink { [weak self] flag in
        if flag {
          DispatchQueue.main.async {
            self?.recalculateStandingsAfterGameReplay()
          }
        }
      }.store(in: &subscriptions)
    }
    
  }
  
  
  // MARK: - Standings
  
  func createStandingsViewModel() {
    let viewModel = StandingsViewModel(teams: teams)
    standingsViewModel = viewModel
  }
 
  func recalculateStandingsAfterGameReplay() {
    TeamStandings.resetStandings(for: teams)
    TeamStandings.updateStandings(for: rounds)
    saveTeams()
  }
  
  
  // MARK: - Save Data
  
  func saveTeams() {
    let fileName = JsonFileName.teams.rawValue
    if let _ = try? DataLoader.save(teams, to: fileName) {
      updateStandings = true
    }
  }
  
  func saveRounds() {
    let fileName = JsonFileName.rounds.rawValue
    try! DataLoader.save(rounds, to: fileName)
  }
  

  
}
