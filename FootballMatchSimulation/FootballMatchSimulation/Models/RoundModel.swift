///
/// RoundModel.swift
///
/// The model to encode from and decode
/// JSON data to for generated game Rounds
///
/// Created by Cristina Dobson
///


import Foundation
import Combine


// MARK: - ROUND MODEL

/*
 A model for every Round
 in the tournament
 */
class Round: Codable {
  
  
  // MARK: - Properties
  
  let name: String
  let matches: [Match]
  
  
  // MARK: - Methods
  
  init(name: String, matches: [Match]) {
    self.name = name
    self.matches = matches
  }
  
  // Ask every Match in the Round to find its Team models
  func findTeamsForMatches(from allTeams: [Team]) {
    for match in matches {
      match.getTeams(from: allTeams)
    }
  }
  
  
  // MARK: - MATCH Model *********
  
  // A single match (Game between 2 teams)
  class Match: Codable {
    
    // MARK: - Properties *********
    
    @Published var saveRounds = false
    @Published var saveTeams = false
    @Published var didReplayGame = false
    
    // Not in JSON
    var teams: [Team] = []
    
    // IDs to aid in loading the Teams
    var team_ids: [String] = []
    
    /*
     If a match has already been played once,
     then the consecutive plays will recalculcate
     the team standings
     */
    var gameIsPlayed = false
    
    /*
     If the match has not been played,
     then it is an empty array
     */
    var scores: [Int] = [] {
      didSet {
        saveRounds = true
      }
    }
    
    // The only keys in the JSON file
    private enum CodingKeys: String, CodingKey {
      case team_ids
      case scores
      case gameIsPlayed
    }
    
    
    // MARK: - Methods *********
    
    init() { }
       
    required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.team_ids = try container.decode([String].self, forKey: .team_ids)
      self.scores = try container.decode([Int].self, forKey: .scores)
      self.gameIsPlayed = try container.decode(Bool.self, forKey: .gameIsPlayed)
    }
    
    
    // MARK: - Helper Methods *********
    
    /*
     Find the Team models with the corresponding
     IDs for the match
     */
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
    
    
    // MARK: - Update Team Standings *********
    
    /*
     Update the Team Standings when the match
     has been played for the first time
     */
    func updateTeamStandings() {
      TeamStandings.updateTeamStandings(from: self)
      saveTeams = true
    }
    
    /*
     If the match has been replayed, then ask to whoever
     is listening, to recalculate the standings for all the Teams
     */
    func gameReplayed() {
      didReplayGame = true
    }
    
  }
  
}
