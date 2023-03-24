//
//  Team.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/17/23.
//


import Foundation


class Team: Codable {
  
  let name: String
  let shortened_name: String
  let id: String
  let stadium: String
  let image_name: String
  let keeper: Player
  let defenders: [Player]
  let midfielders: [Player]
  let attackers: [Player]
  
  var standings: Standings!
  
  
  class Standings: Codable {
    
    enum GameResult {
      case win
      case draw
    }
    
    var games_played = 0
    var points = 0
    
    // Matches
    var wins: Int = 0 {
      didSet {
        calculatePoints(for: .win)
      }
    }
    
    var draws: Int = 0 {
      didSet {
        calculatePoints(for: .draw)
      }
    }
    
    var losses = 0
    
    
    // Goals
    var goals_for = 0
    var goals_against = 0
    
    var goalsDifference: Int {
      return goals_for - goals_against
    }
    
    
    // MARK: - Methods
    
    func calculatePoints(for result: GameResult) {
      switch result {
        case .win:
          points += 3
        case .draw:
          points += 1
      }
    }
    
    func reset() {
      wins = 0
      draws = 0
      losses = 0
      goals_for = 0
      goals_against = 0
      points = 0
      games_played = 0
    }
    
  }
  
}



class Player: Codable {
  
  let name: String
  let shirt: Int
  let position: String
  let skillPower: Double
  
}




