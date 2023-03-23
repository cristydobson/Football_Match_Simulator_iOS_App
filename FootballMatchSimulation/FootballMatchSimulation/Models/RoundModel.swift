//
//  RoundModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation


class Round: Codable {
  
  class Match: Codable {
    
    var teams: [TeamModel] = []
    
    var team_ids: [String] = []
    var scores: [Int] = []
    var gameIsPlayed = false
    
    
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
  }
  
  let name: String
  let matches: [Match]
  
  init(name: String, matches: [Match]) {
    self.name = name
    self.matches = matches
  }
  
}
