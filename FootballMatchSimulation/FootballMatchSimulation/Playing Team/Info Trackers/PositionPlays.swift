///
/// PositionPlays.swift
///
/// The Plays a given Position in
/// the team has played.
///
/// Each Play represents 1 minute
/// of play time in real life.
///
/// (e.g.)
///   A game lasts 90 Plays,
///   which is equivalent to
///   90 minutes in real life.
///
///   Created by Cristina Dobson
///


import Foundation


class PositionPlays {
  
  // MARK: - Properties
  
  /*
   Keep track of the Plays each
   Position on the Team has played
   */
  private var keeper = 0
  private var defenders = 0
  private var midfielders = 0
  private var attackers = 0
  
  
  // MARK: - Methods
  
  func updatePlays(for position: Position) {
    switch position {
        
      case .keeper:
        keeper += 1
        
      // Midfielders help Defenders
      case .defender:
        defenders += 1
        midfielders += 1
        
      case .midfielder:
        midfielders += 1
        
      // Midfielders help Attackers
      case .attacker:
        attackers += 1
        midfielders += 1
    }
  }
  
  // Retrieve Plays count per Position
  func getPlays(for position: Position) -> Int {
    switch position {
        
      case .keeper:
        return keeper
        
      case .defender:
        return defenders
        
      case .midfielder:
        return midfielders
        
      case .attacker:
        return attackers
    }
  }
  
}




