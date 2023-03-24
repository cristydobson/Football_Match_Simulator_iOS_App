//
//  RoundModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import Combine


class Round: Codable {
  
  class Match: Codable {
    
    var teams: [Team] = []
    
    var team_ids: [String] = []
    
    var scores: [Int] = [] {
      didSet {
        saveRounds = true
      }
    }
    
    var gameIsPlayed = false
    
    @Published var saveRounds = false
    @Published var saveTeams = false
    @Published var didReplayGame = false
    
    private enum CodingKeys: String, CodingKey {
      case team_ids
      case scores
      case gameIsPlayed
    }
    
    init() { }
    
    required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.team_ids = try container.decode([String].self, forKey: .team_ids)
      self.scores = try container.decode([Int].self, forKey: .scores)
      self.gameIsPlayed = try container.decode(Bool.self, forKey: .gameIsPlayed)
    }
    
    func getTeams(from allTeams: [Team]) {
      var teamModels: [Team] = []
      
      for id in team_ids {
        for team in allTeams {
          if team.id == id {
            teamModels.append(team)
            break
          }
        }
      }
      teams = teamModels
    }
    
    
    // MARK: - Update Team Standings
    
    func updateTeamStandings() {
      TeamStandings.updateStandings(for: self)
      saveTeams = true
    }
    
    func gameReplayed() {
      didReplayGame = true
    }
    
  }
  
  let name: String
  let matches: [Match]
  
  init(name: String, matches: [Match]) {
    self.name = name
    self.matches = matches
  }
  
  func findTeamsForMatches(from allTeams: [Team]) {
    for match in matches {
      match.getTeams(from: allTeams)
    }
  }
  
}
