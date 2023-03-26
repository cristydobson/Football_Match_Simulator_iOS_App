///
/// Team.swift
///
/// A model to decode the Teams.json data into,
/// and to save new data to Standings.
///
/// Created by Cristina Dobson
///


import Foundation


// MARK: - TEAM MODEL

class Team: Codable {
  
  // MARK: - Properties
  
  /*
   Keys in the JSON file
   */
  let name: String
  
  // Used in the standings card
  let shortened_name: String
  
  /*
   Used to find the Team models of every
   match in the Round.Match model
   */
  let id: String
  
  // The team's home stadium
  let stadium: String
  
  // Logo
  let image_name: String
  
  // Players per position they play
  let keeper: Player
  let defenders: [Player]
  let midfielders: [Player]
  let attackers: [Player]
  
  var standings: Standings!
  
  
  
  // MARK: - STANDINGS Model *********
  
  /*
   Updated through out the app, and then saved
   into DocumentDirectory along with the Team model.
   */
  class Standings: Codable {
    
    enum GameResult {
      case win
      case draw
    }
    
    // MARK: - Properties *********
    
    // Maximum number of games played is n Rounds
    var games_played = 0
    
    // Accumulated Points
    var points = 0
    
    /*
     Match Outcomes
     */
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
    
    
    /*
     Goals
     */
    var goals_for = 0
    var goals_against = 0
    
    // Not in JSON
    var goalsDifference: Int {
      return goals_for - goals_against
    }
    
    /*
     Not in JSON.
     Used when generating Rounds, to make sure
     every team plays at Home at least once
     */
    var hasPlayedHome = false
    
    
    // The only keys in the JSON file
    private enum CodingKeys: String, CodingKey {
      case games_played
      case wins
      case draws
      case losses
      case goals_for
      case goals_against
    }
    
    
    // MARK: - Methods *********
    
    // Add points for every Win and Draw
    func calculatePoints(for result: GameResult) {
      switch result {
        case .win:
          points += 3
        case .draw:
          points += 1
      }
    }
    
    /*
     Reset all values to zero, before recalculating
     the team Standings, after a match has been replayed.
     */
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


// MARK: - PLAYER MODEL

/*
 Model for every individual Player
 in the team
 */
class Player: Codable {
  
  let name: String
  let shirt: Int
  let position: String
  let skillPower: Double
  
}




