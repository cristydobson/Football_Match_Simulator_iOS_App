//
//  SkillPower.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation


final class SkillPower {
  
  
  // MARK: - Properties
  
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
   Get the SkillPower for the Midfielders.
   Add 1 to the totalSkillPower for every
   player in the lineup with the same position.
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
   Add 1 to the totalSkillPower for every
   player in the lineup with the same position.
   
   Defenders & Attackers' SkillPower is higher because they
   receive help in-game from the Midfielders.
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
  
  private static func skillPowerSummation(for players: [Player]) -> Double {
    
    var totalSkillPower: Double = 0.0
    
    for player in players {
      totalSkillPower += player.skillPower
    }
    
    return totalSkillPower
  }
  
  
  
}












