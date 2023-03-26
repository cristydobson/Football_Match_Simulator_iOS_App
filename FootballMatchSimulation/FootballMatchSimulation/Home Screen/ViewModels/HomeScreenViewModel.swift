///
/// HomeScreenViewModel.swift
///
/// The ViewModel for the Root ViewController.
/// Contains the Standings and the Rounds.
///
/// Created by Cristina Dobson
///


import Foundation
import Combine


class HomeScreenViewModel: ObservableObject {
  
  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  
  // Decoded Round and Team models
  @Published var rounds: [Round] = []
  @Published var teams: [Team] = []
  
  // The ViewModel to pass to the StandingsView
  @Published var standingsViewModel: StandingsViewModel!
  @Published var updateStandings = false
  
  
  // MARK: - Load Teams
  
  /*
   Load the Teams file from the DocumentDirectory
   if it exists, otherwise, load it from the Bundle
   and then save it to the DocumentDirectory
   */
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
  
  /*
   Load the Rounds file from the DocumentDirectory
   if it exists, otherwise, generate new Round models
   and then save them to the DocumentDirectory
   */
  func loadRounds(with teamModels: [Team]) {
    let fileName = JsonFileName.rounds.rawValue
    
    if let newRounds = try? DataLoader.loadDataFromDirectory([Round].self, from: fileName),
       newRounds.count > 0 {
      setupExistingRounds(newRounds)
    }
    else {
      createNewRounds(with: teamModels, andFileName: fileName)
    }
  }
  
  
  // MARK: Setup Existing Rounds
  
  /*
   Add Teams to every existing Round.Match
   and setup their bindings
   */
  func setupExistingRounds(_ newRounds: [Round]) {
    setupRoundBindings(for: newRounds)
    setupRounds(newRounds)
  }
  
  func setupRounds(_ roundModels: [Round]) {
    for round in roundModels {
      round.findTeamsForMatches(from: teams)
    }
    rounds = roundModels
  }
  
  
  // MARK: - Create New Rounds
  
  // Create new Rounds after first app launch
  func createNewRounds(with teamModels: [Team], andFileName fileName: String) {
    let newRounds = generateRounds(teamModels)
    setupRoundBindings(for: newRounds)
    try! DataLoader.save(newRounds, to: fileName)
  }
  
  // Generate rounds for the first time
  func generateRounds(_ models: [Team]) -> [Round] {
    let generator = RoundGenerator()
    let newRounds = generator.getRounds(from: models)
    rounds = newRounds
    return newRounds
  }
  
  
  // MARK: - Setup Bindings
  
  // Setup bindings for for every Round.Match
  func setupRoundBindings(for roundModels: [Round]) {
    for round in roundModels {
      setupBindings(for: round)
    }
  }
  
  func setupBindings(for round: Round) {
    for match in round.matches {
      setupBindings(for: match)
    }
  }
  
  func setupBindings(for match: Round.Match) {
    
    // Listen to save Rounds to DocumentDirectory
    match.$saveRounds.sink { [weak self] flag in
      if flag {
        DispatchQueue.main.async {
          self?.saveRounds()
        }
      }
    }.store(in: &subscriptions)
    
    // Listen to save Teams to DocumentDirectory
    match.$saveTeams.sink { [weak self] flag in
      if flag {
        DispatchQueue.main.async {
          self?.saveTeams()
        }
      }
    }.store(in: &subscriptions)
    
    /*
     Listen to recalculate every Team's standings,
     and then save Teams to DocumentDirectory
     */
    match.$didReplayGame.sink { [weak self] flag in
      if flag {
        DispatchQueue.main.async {
          self?.recalculateStandingsAfterGameReplay()
        }
      }
    }.store(in: &subscriptions)
  }
  
  
  // MARK: - Standings
  
  // Create the ViewModel for the Standings View
  func createStandingsViewModel() {
    let viewModel = StandingsViewModel(teams: teams)
    standingsViewModel = viewModel
  }
 
  /*
   Recalculate every Team's standings after
   replaying a Match
   */
  func recalculateStandingsAfterGameReplay() {
    TeamStandings.resetStandings(for: teams)
    TeamStandings.updateTeamStandings(from: rounds)
    saveTeams()
  }
  
  
  // MARK: - Save Data
  
  // Save Teams to DocumentDirectory
  func saveTeams() {
    let fileName = JsonFileName.teams.rawValue
    try! DataLoader.save(teams, to: fileName)
    updateStandings = true
  }
  
  // Save Rounds to DocumentDirectory
  func saveRounds() {
    let fileName = JsonFileName.rounds.rawValue
    try! DataLoader.save(rounds, to: fileName)
  }
  
}
