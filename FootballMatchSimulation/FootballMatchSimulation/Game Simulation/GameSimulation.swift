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
  
  private var subscriptions = Set<AnyCancellable>()
  
  private let team1: PlayingTeam
  private let team2: PlayingTeam
  
//  private var ballPossession: PlayingTeam!
  
  @Published private(set) var plays = 0
  
  @Published private(set) var currentEvent: String = ""
  
  @Published private(set) var team1Goals = 0
  @Published private(set) var team2Goals = 0
  
  
  var isHalfTime: Bool {
    return plays == 45
  }
  
  var matchInProgress: Bool {
    return plays < 90
  }
  
  
  // MARK: - Init Method
  
  init(team1: PlayingTeam, team2: PlayingTeam) {
    self.team1 = team1
    self.team2 = team2
    
    setupBindings()
  }
  
  
  
  // MARK: - Start Simulation
  
  func startFirstTimeSimulation() {
    battle(team1, vs: team2)
  }
  
  func startSecondTimeSimulation() {
    team1.resetPosition()
    team2.resetPosition()
    battle(team2, vs: team1)
  }
  
  func handleHalfTime() {
    currentEvent = eventString(for: .halfTime, andTeam: nil)
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.startSecondTimeSimulation()
    }
  }
  
  
  // MARK: - Handle Simulation

  func battle(_ team1: PlayingTeam, vs team2: PlayingTeam) {
    
    plays += 1
    print("\(plays). ----->")
    
    if isHalfTime {
      handleHalfTime()
    }
    else if matchInProgress {
      
      if isMorePowerful(team2, than: team1) {
        
        if nonKeeperCommittedFoul(from: team2) {
          foulBy(team2, against: team1)
        }
        else {
          takesBall(team2, from: team1)
        }
      }
      else { // team1 > team2
        
        if team2.isGoalKeeper {
          handleGoalScoring(from: team1, against: team2)
        }
        else {
          
          if team1.commitedFoul() {
            foulBy(team1, against: team2)
          }
          else {
            keepsBall(team1, against: team2)
          }
          
        }
        
      }
      
    }
    else { // MATCH ENDED
      currentEvent = eventString(for: .matchFinished, andTeam: nil)
      print("MATCH IS DONE!!!!!")
      print("GOALS: \(team1.name)(\(team1.goals)) - \(team2.name)(\(team2.goals))")
      
    }
    
  }
  
  
  // MARK: - Compare SkillPower
  
  func isMorePowerful(_ team2: PlayingTeam, than team1: PlayingTeam) -> Bool {
    let teamOneSkillPower = team1.playersSkillPower()
    let teamTwoSkillPower = team2.playersSkillPower()
    
    print("\(team1.name) as \(team1.currentPosition.rawValue) (POWER: \(teamOneSkillPower)) VS. \(team2.name) as \(team2.currentPosition.rawValue) (POWER: \(teamTwoSkillPower)) \n")
    
    return teamTwoSkillPower >= teamOneSkillPower
  }
  
  
  // MARK: - Handle Fouls
  
  func foulBy(_ teamOne: PlayingTeam, against teamTwo: PlayingTeam) {
    
    currentEvent = eventString(for: .foul, andTeam: teamOne)
    
    handleFoulBy(teamOne, against: teamTwo)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.battle(teamTwo, vs: teamOne)
    }
  }
  
  func handleFoulBy(_ teamOne: PlayingTeam, against teamTwo: PlayingTeam) {
    let foul = team1.getFoulPenaltyType()
    print("FOUL: \(foul)!!!!")
    teamOne.handleCommittedFoul(foul)
    teamTwo.handleReceivedFoul(foul)
  }
  
  func nonKeeperCommittedFoul(from team: PlayingTeam) -> Bool {
    return team.commitedFoul() && !team.isGoalKeeper
  }
  
  
  // MARK: - Handle Play Events
  
  func takesBall(_ teamTwo: PlayingTeam, from teamOne: PlayingTeam) {
    currentEvent = eventString(for: .takesBall, andTeam: teamTwo)
    
    teamOne.fallBackPosition(against: teamTwo.currentPosition)
    teamTwo.nextPosition()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.battle(teamTwo, vs: teamOne)
    }
  }
  
  func keepsBall(_ teamOne: PlayingTeam, against teamTwo: PlayingTeam) {
    currentEvent = eventString(for: .keepsBall, andTeam: teamOne)
    
    teamTwo.fallBackPosition(against: teamOne.currentPosition)
    teamOne.nextPosition()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.battle(teamOne, vs: teamTwo)
    }
  }
  
  func handleGoalScoring(from teamOne: PlayingTeam, against teamTwo: PlayingTeam) {
    currentEvent = eventString(for: .goal, andTeam: teamOne)
    
    teamTwo.nextPosition()
    teamOne.updateGoals()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.battle(teamTwo, vs: teamOne)
    }
  }
  
  
  // MARK: - Event Strings
  
  enum Event {
    case foul
    case takesBall
    case keepsBall
    case goal
    case halfTime
    case matchFinished
    
    func string() -> String {
      switch self {
        case .foul:
          return "Foul by "
        case .takesBall:
          return " takes the ball"
        case .keepsBall:
          return " keeps the ball"
        case .goal:
          return "Goal by "
        case .halfTime:
          return "HALF TIME!!!!"
        case .matchFinished:
          return "MATCH FINISHED!!!!"
      }
    }
  }
  
  func eventString(for event: Event, andTeam team: PlayingTeam?) -> String {
    switch event {
      case .foul:
        return event.string() + team!.name
      case .takesBall, .keepsBall:
        return team!.name + "'s " + team!.currentPosition.rawValue + event.string()
      case .goal:
        return event.string() + team!.name
      case .halfTime, .matchFinished:
        return event.string()
    }
  }

  
  // MARK: - Bindings
  
  func setupBindings() {
    
    team1.$goals.sink { [weak self] goals in
      self?.team1Goals = goals
    }
    .store(in: &subscriptions)
    
    team2.$goals.sink { [weak self] goals in
      self?.team2Goals = goals
    }
    .store(in: &subscriptions)
    
  }
  
  
}
