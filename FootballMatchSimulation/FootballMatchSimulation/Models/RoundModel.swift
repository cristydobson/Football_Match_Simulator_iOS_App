//
//  RoundModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation


class Round {
  
  let name: String
  let matches: [Match]
  
  init(name: String, matches: [Match]) {
    self.name = name
    self.matches = matches
  }
  
  class Match {
    let teams: [TeamModel]
    var scores: [Int]
    var gameIsPlayed = false
    
    init(teams: [TeamModel], scores: [Int]) {
      self.teams = teams
      self.scores = scores
    }
  }
}
