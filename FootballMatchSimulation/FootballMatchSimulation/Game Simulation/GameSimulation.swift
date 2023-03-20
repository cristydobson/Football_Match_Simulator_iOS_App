//
//  GameSimulation.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation
import Combine


class GameSimulation: ObservableObject {
  
  
  // MARK: - Properties
  
  private let team1: PlayingTeam
  private let team2: PlayingTeam
  
  private var ballPossession: PlayingTeam!
  
  private var plays = 0
  
  @Published private(set) var currentEvent: String = ""
  
  
  // MARK: - Init Method
  
  init(team1: PlayingTeam, team2: PlayingTeam) {
    self.team1 = team1
    self.team2 = team2
    
    
  }
  
  
  
  // MARK: - Start Simulation
  
  func startSimulation() {
    ballPossession = team1
    battle(team1, vs: team2)
  }
  
  
  
  // MARK: - Handle Simulation

  func battle(_ team1: PlayingTeam, vs team2: PlayingTeam) {
    
    plays += 1
    print("\(plays). ----->")
    
    if plays < 90 {
      let teamOneSkillPower = team1.playersSkillPower()
      let teamTwoSkillPower = team2.playersSkillPower()
      
      print("\(team1.name) as \(team1.currentPosition.rawValue) (POWER: \(teamOneSkillPower)) VS. \(team2.name) as \(team2.currentPosition.rawValue) (POWER: \(teamTwoSkillPower)) \n")
      
      
      if teamTwoSkillPower >= teamOneSkillPower {
        if team2.commitedFoul() && team2.currentPosition != .keeper {
          print("FOUL BY T2: \(team2.name)!!!!")
          currentEvent = "Foul by \(team2.name)"
          foulBy(teamOne: team2, against: team1)
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.battle(team1, vs: team2)
          }
        }
        else {
          currentEvent = "\(team2.name)'s \(team2.currentPosition.rawValue) takes the ball"
          ballPossession = team2
          team1.fallBackPosition(against: team2.currentPosition)
          team2.nextPosition()
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.battle(team2, vs: team1)
          }
        }
      }
      else { // team1 > team2
        
        if team2.currentPosition == .keeper {
          print("GOAL by \(team1.name)!!!!!!!!!!!!")
          currentEvent = "GOAL by \(team1.name)!!!"
          ballPossession = team2
          team2.nextPosition()
          team1.updateGoals()
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.battle(team2, vs: team1)
          }
        }
        else {
          if team1.commitedFoul() {
            print("FOUL BY T1: \(team1.name)!!!!")
            currentEvent = "Foul by \(team1.name)"
            foulBy(teamOne: team1, against: team2)
            ballPossession = team2
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              self.battle(team2, vs: team1)
            }
          }
          else {
            currentEvent = "\(team1.name)'s \(team1.currentPosition.rawValue) keeps the ball"
            team2.fallBackPosition(against: team1.currentPosition)
            team1.nextPosition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              self.battle(team1, vs: team2)
            }
          }
        }
        
      }
    }
    else {
      currentEvent = "MATCH DONE!!!!!!!"
      print("MATCH IS DONE!!!!!")
      print("GOALS: \(team1.name)(\(team1.goals)) - \(team2.name)(\(team2.goals))")
      
    }
    
  }
  
  
  func foulBy(teamOne team1: PlayingTeam, against team2: PlayingTeam) {
    
    let foul = team1.getFoulPenaltyType()
    print("FOUL: \(foul)!!!!")
    team1.handleCommittedFoul(foul)
    team2.handleReceivedFoul(foul)
    
  }

  
  
  
}
