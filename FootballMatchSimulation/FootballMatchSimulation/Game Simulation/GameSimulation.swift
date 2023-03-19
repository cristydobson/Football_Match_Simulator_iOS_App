//
//  GameSimulation.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation


class GameSimulation {
  
  
  // MARK: - Properties
  
  private let team1: PlayingTeam
  private let team2: PlayingTeam
  
  private var ballPossession: PlayingTeam!
  
  
  
  // MARK: - Init Method
  
  init(team1: PlayingTeam, team2: PlayingTeam) {
    self.team1 = team1
    self.team2 = team2
    
    startSimulation()
  }
  
  
  
  // MARK: - Start Simulation
  
  func startSimulation() {
    ballPossession = team1
    battle(team1, vs: team2)
  }
  
  
  
  // MARK: - Handle Simulation
  
  func battle(_ team1: PlayingTeam, vs team2: PlayingTeam) {
    
    let teamOneSkillPower = team1.playersSkillPower()
    let teamTwoSkillPower = team2.playersSkillPower()
    
    print("\(team1.name) as \(team1.currentPosition.rawValue) (POWER: \(teamOneSkillPower)) VS. \(team2.name) as \(team2.currentPosition.rawValue) (POWER: \(teamTwoSkillPower)) \n")
    
    
    if teamTwoSkillPower >= teamOneSkillPower {
      if team2.commitedFoul() && team2.currentPosition != .keeper {
        print("FOUL BY T2: \(team2.name)!!!!")
        foulBy(teamOne: team2, against: team1)
        battle(team1, vs: team2)
      }
      else {
        ballPossession = team2
        team1.fallBackPosition(against: team2.currentPosition)
        team2.nextPosition()
        battle(team2, vs: team1)
      }
    }
    else { // team1 > team2
      
      if team2.currentPosition == .keeper {
        ballPossession = team2
        team2.nextPosition()
        //        print("GOAL for \(team1.name) and possession: \(ballPossession.name)!!!!!!!!!!!!")
        print("GOAL by \(team1.name)!!!!!!!!!!!!")
      }
      else {
        if team1.commitedFoul() {
          print("FOUL BY T1: \(team1.name)!!!!")
          foulBy(teamOne: team1, against: team2)
          ballPossession = team2
          battle(team2, vs: team1)
        }
        else {
          team2.fallBackPosition(against: team1.currentPosition)
          team1.nextPosition()
          battle(team1, vs: team2)
        }
      }
      
    }
    
  }
  
  
  func foulBy(teamOne team1: PlayingTeam, against team2: PlayingTeam) {
    
    let foul = team1.getFoulPenaltyType()
    print("FOUL: \(foul)!!!!")
    team1.handleCommittedFoul(foul)
    team2.handleReceivedFoul(foul)
    
  }

  
  
  
}
