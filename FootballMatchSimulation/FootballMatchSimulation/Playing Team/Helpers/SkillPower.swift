///
/// SkillPower.swift
///
/// Calculate the SkillPower for a Position in a Team's
/// lineup, for it to use in the Head-to-Head battle.
///
/// Midfielders SkillPower  = midfielders skillPower
/// Attackers SkillPower = (attackers + 1/2 midfielders) skillPower
/// Defenders SkillPower = (defenders + 1/2 midfielders) skillPower
///
///  Created by Cristina Dobson
///


import Foundation


final class SkillPower {
  
  
  // MARK: - Properties
  
  // Makes the Keeper more powerful against Attackers
  private static var scoringDifficulty: Double = 8
  
  
  // MARK: - Methods
  
  // Get the SkillPower for a given field position
  static func getSkillPower(for position: Position, withPlayers players: Players) -> Double {
    
    let midfielders = players.midfielders
    
    switch position {
        
      case .attacker:
        return getSkillPower(
          for: players.attackers, helpedBy: midfielders)
        
      case .midfielder:
        return getSkillPower(for: midfielders)
        
      case .defender:
        return getSkillPower(
          for: players.defenders, helpedBy: midfielders)
        
      case .keeper:
        return players.keeper.skillPower * scoringDifficulty
    }
  }
  
  
  /*
   Get the SkillPower for a single Position.
   
   Then add +1 for every player in the lineup with
   the same position to the totalSkillPower.
   */
  private static func getSkillPower(for players: [Player]) -> Double {
    
    let skillPower = skillPowerSummation(for: players)
    
    let averageSkillPower = DoubleHelper.getRoundedAverageNumber(
      for: skillPower, withCount: players.count)
    
    let totalSkillPower = averageSkillPower + Double(players.count)
    
    return totalSkillPower
  }
  
  /*
   Get the SkillPower for the Defenders & Attackers.
   
   Then add +1 for every player in the lineup with
   the same position to the totalSkillPower.
   
   Defenders & Attackers SkillPower is higher than the
   Midfielders alone, because they receive help in-game
   from the Midfielders too.
   */
  private static func getSkillPower(for players: [Player], helpedBy neighborPlayers: [Player]) -> Double {
    
    let playersSkillPower = getSkillPower(for: players)
    let neighborsSkillPower = getSkillPower(for: neighborPlayers)
    
    // Neighbors SkillPower help
    let neighborsHelp = (neighborsSkillPower/2).rounded(to: 2)
    
    // Total player SkillPower
    let bothSkillPowers = playersSkillPower + neighborsHelp
    let totalSkillPower = bothSkillPowers + Double(players.count)
    
    return totalSkillPower
  }
  
  
  // MARK: - Summations
  
  /*
   Add up all the SkillPowers from every player
   with the same Position in the line-up
   */
  private static func skillPowerSummation(for players: [Player]) -> Double {
    
    var totalSkillPower: Double = 0.0
    
    for player in players {
      totalSkillPower += player.skillPower
    }
    
    return totalSkillPower
  }
  
}












