//
//  GameSimulation.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation
import Combine


class GameSimulation: ObservableObject {
  
  
  enum GameState {
    case none
    case inProgress
    case halfTime
    case finished
  }
  
  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  
  private let homeTeam: PlayingTeam
  private let visitorTeam: PlayingTeam
  
//  private var ballPossession: PlayingTeam!
  
  @Published private(set) var plays = 0
  
  @Published private(set) var currentEvent: String = ""
  
  @Published private(set) var team1Goals = 0
  @Published private(set) var team2Goals = 0
  
  @Published private(set) var gameState = GameState.none
  
  
  var isHalfTime: Bool {
    return plays == 45
  }
  
  var matchInProgress: Bool {
    return plays < 90
  }
  
  
  // MARK: - Init Method
  
  init(homeTeam: PlayingTeam, visitorTeam: PlayingTeam) {
    self.homeTeam = homeTeam
    self.visitorTeam = visitorTeam
    
    setupBindings()
  }
  
  
  
  // MARK: - Start Simulations
  
  func startFirstTimeSimulation() {
    gameState = .inProgress
    battle(homeTeam, vs: visitorTeam)
  }
  
  func startSecondTimeSimulation() {
    gameState = .inProgress
    
    homeTeam.resetPosition()
    visitorTeam.resetPosition()
    
    battle(visitorTeam, vs: homeTeam)
  }
  
  
  // MARK: - Handle Simulation Phases
  
  func handleHalfTime() {
    gameState = .halfTime
    
    currentEvent = eventString(for: .halfTime, andTeam: nil)
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.startSecondTimeSimulation()
    }
  }
  
  func handleGameInProgress(for teamOne: PlayingTeam, vs teamTwo: PlayingTeam) {
    
    if isMorePowerful(teamTwo, than: teamOne) {
      
      if nonKeeperCommittedFoul(from: teamTwo) {
        foulBy(teamTwo, against: teamOne)
      }
      else {
        takesBall(teamTwo, from: teamOne)
      }
    }
    else { // team1 > team2
      
      if teamTwo.isGoalKeeper {
        handleGoalScoring(from: teamOne, against: teamTwo)
      }
      else {
        
        if teamOne.commitedFoul() {
          foulBy(teamOne, against: teamTwo)
        }
        else {
          keepsBall(teamOne, against: teamTwo)
        }
        
      }
      
    }
    
  }
  
  func handleFinishedMatch(for teamOne: PlayingTeam, vs teamTwo: PlayingTeam) {
    gameState = .finished
    
    currentEvent = eventString(for: .matchFinished, andTeam: nil)
    print("MATCH IS DONE!!!!!")
    print("GOALS: \(teamOne.name)(\(teamOne.goals)) - \(teamTwo.name)(\(teamTwo.goals))")
  }
  
  
  // MARK: - Handle Players Head-To-Head Simulation

  
  func battle(_ team1: PlayingTeam, vs team2: PlayingTeam) {
    
    plays += 1
    print("\(plays). ----->")
    
    if isHalfTime {
      handleHalfTime()
    }
    else if matchInProgress {
      handleGameInProgress(for: team1, vs: team2)
    }
    else { // MATCH ENDED
      handleFinishedMatch(for: team1, vs: team2)
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
    let foul = teamOne.getFoulPenaltyType()
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
    
    homeTeam.$goals.sink { [weak self] goals in
      self?.team1Goals = goals
    }
    .store(in: &subscriptions)
    
    visitorTeam.$goals.sink { [weak self] goals in
      self?.team2Goals = goals
    }
    .store(in: &subscriptions)
    
  }
  
  
}
