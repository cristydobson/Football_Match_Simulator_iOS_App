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
    case goalScored
    case inProgress
    case halfTime
    case finished
  }
  
  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  
  private let homeTeam: PlayingTeam
  private let visitorTeam: PlayingTeam
  
  @Published private(set) var plays = 0
  @Published private(set) var currentEvent: String = ""
  
  @Published private(set) var team1Goals = 0
  @Published private(set) var team2Goals = 0
  
  @Published private(set) var gameState = GameState.none
  
  
  private var isHalfTime: Bool {
    return plays == 45
  }
  
  private var matchInProgress: Bool {
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
  
  
  // MARK: - Handle Players Head-To-Head Simulation
  
  func battle(_ team1: PlayingTeam, vs team2: PlayingTeam) {
    
    plays += 1
    
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
  
  
  // MARK: - Handle Simulation States
  
  /*
   Half-Time
   */
  func handleHalfTime() {
    gameState = .halfTime
    
    currentEvent = ""

    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.startSecondTimeSimulation()
    }
  }
  
  /*
   Game In-Progress
   */
  func handleGameInProgress(for teamOne: PlayingTeam, vs teamTwo: PlayingTeam) {
    
    if isMorePowerful(teamTwo, than: teamOne) {
      handleSkillPowerWin(ofTeamTwo: teamTwo, against: teamOne)
    }
    else { // teamOne > teamTwo
      handleSkillPowerWin(ofTeamOne: teamOne, against: teamTwo)
    }
  }
  
  func handleSkillPowerWin(ofTeamTwo teamTwo: PlayingTeam, against teamOne: PlayingTeam) {
    if notAKeeperCommittedFoul(from: teamTwo) {
      foulBy(teamTwo, against: teamOne)
    }
    else {
      ballPossession(teamOne: teamTwo, teamTwo: teamOne, for: .takesBall)
    }
  }
  
  func handleSkillPowerWin(ofTeamOne teamOne: PlayingTeam, against teamTwo: PlayingTeam) {
    
    if teamTwo.isGoalKeeper {
      goalScoring(from: teamOne, against: teamTwo)
    }
    else if teamOne.commitedFoul() {
      foulBy(teamOne, against: teamTwo)
    }
    else {
      ballPossession(teamOne: teamOne, teamTwo: teamTwo, for: .keepsBall)
    }
  }
  
  
  /*
   Match Ended
   */
  func handleFinishedMatch(for teamOne: PlayingTeam, vs teamTwo: PlayingTeam) {
    gameState = .finished
    currentEvent = ""
  }
  
  
  // MARK: - Compare Team SkillPowers
  
  func isMorePowerful(_ team2: PlayingTeam, than team1: PlayingTeam) -> Bool {
    
    let teamOneSkillPower = team1.playersSkillPower()
    let teamTwoSkillPower = team2.playersSkillPower()
    
    return teamTwoSkillPower >= teamOneSkillPower
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
  
  func updateCurrentEvent(for event: Event, andTeam team: PlayingTeam?) {
    currentEvent = EventHelper.eventString(for: event, andTeam: team)
  }
  
}


// MARK: - Handle Play Events

extension GameSimulation {
  
  func ballPossession(teamOne: PlayingTeam, teamTwo: PlayingTeam, for event: Event) {
    updateCurrentEvent(for: event, andTeam: teamOne)
    teamTwo.fallBackPosition(against: teamOne.currentPosition)
    teamOne.nextPosition()

    nextBattle(teamOne, vs: teamTwo, andWait: 1)
  }
  
  func goalScoring(from teamOne: PlayingTeam, against teamTwo: PlayingTeam) {
    updateCurrentEvent(for: .goal, andTeam: teamOne)
    teamTwo.nextPosition()
    teamOne.updateGoals()

    gameState = .goalScored
    
    nextBattle(teamTwo, vs: teamOne, andWait: 2)
  }
  
  func nextBattle(_ teamOne: PlayingTeam, vs teamTwo: PlayingTeam, andWait time: TimeInterval) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
      self.battle(teamOne, vs: teamTwo)
    }
  }
  
}


// MARK: - Handle Fouls

extension GameSimulation {
  
  func foulBy(_ teamOne: PlayingTeam, against teamTwo: PlayingTeam) {
    updateCurrentEvent(for: .foul, andTeam: teamOne)
    handleFoulBy(teamOne, against: teamTwo)
    nextBattle(teamTwo, vs: teamOne, andWait: 1)
  }
  
  func handleFoulBy(_ teamOne: PlayingTeam, against teamTwo: PlayingTeam) {
    let foul = teamOne.getFoulPenaltyType()
    teamOne.handleCommittedFoul(foul)
    teamTwo.handleReceivedFoul(foul)
  }
  
  func notAKeeperCommittedFoul(from team: PlayingTeam) -> Bool {
    return team.commitedFoul() && !team.isGoalKeeper
  }
  
}

