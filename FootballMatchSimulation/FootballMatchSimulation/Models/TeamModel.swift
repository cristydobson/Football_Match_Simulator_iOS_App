//
//  TeamModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation


class TeamModel {
  
  
  // MARK: - Properties
  
  private(set) var name: String
  private(set) var stadium: String
  private(set) var imageName: String
  
  private(set) var keeper: Player
  private(set) var defenders: [Player]
  private(set) var midfielders: [Player]
  private(set) var attackers: [Player]
  
  private(set) var standings: Standings
  
  
  // MARK: - Init Method
  
  init(name: String, stadium: String, imageName: String, keeper: Player, defenders: [Player], midfielders: [Player], attackers: [Player]) {
    self.name = name
    self.stadium = stadium
    self.imageName = imageName
    self.keeper = keeper
    self.defenders = defenders
    self.midfielders = midfielders
    self.attackers = attackers
    standings = Standings()
  }
  
  
  
  class Standings {
    
    enum GameResult {
      case win
      case draw
    }
    
    
    // MARK: - Properties
    
//    var leaderBoardPosition = 0
    
    var gamesPlayed = 0
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
    var goalsFor = 0
    var goalsAgainst = 0
    
    var goalsDifference: Int {
      return goalsFor - goalsAgainst
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
    
    
  }
  
  
}
