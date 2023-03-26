///
/// GameSimulation.swift
///
/// It handles a Game/Match between 2 Teams.
///
/// Created by Cristina Dobson
///


import Foundation
import Combine


class GameSimulation: ObservableObject {
  
  /*
   The states a single match
   goes through
   */
  enum GameState {
    case aboutToStart
    case goalScored
    case inProgress
    case halfTime
    case finished
  }
  
  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  
  // Teams currently playing
  private let homeTeam: PlayingTeam
  private let visitorTeam: PlayingTeam
  
  // Game's current state
  @Published private(set) var plays = 0
  @Published private(set) var currentEvent: String = ""
  
  @Published private(set) var team1Goals = 0
  @Published private(set) var team2Goals = 0
  
  @Published private(set) var gameState = GameState.aboutToStart
  
  
  // At 45 Plays the game enters Half-Time
  private var isHalfTime: Bool {
    return plays == 45
  }
  
  // At 90 Plays, the game ends
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
  
  /*
   Start the first half of the game.
   
   The HomeTeam kicks-off the game.
   */
  func startFirstHalfSimulation() {
    gameState = .inProgress
    nextBattle(homeTeam, vs: visitorTeam, andWait: 1.7)
  }
  
  /*
   Start the second half of the game
   after half-time.
   
   The VisitorTeam kicks off the game now.
   */
  func startSecondHalfSimulation() {
    gameState = .inProgress
    
    // Both teams go back to the midfield
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

    //Wait before kicking-off the second half of the game
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.startSecondHalfSimulation()
    }
  }
  
  /*
   Game In-Progress
   */
  func handleGameInProgress(for teamOne: PlayingTeam, vs teamTwo: PlayingTeam) {
    
    // Team2 wins the Head2Head
    if isMorePowerful(teamTwo, than: teamOne) {
      handleSkillPowerWin(ofTeamTwo: teamTwo, against: teamOne)
    }
    else { // Team1 wins the Head2Head
      handleSkillPowerWin(ofTeamOne: teamOne, against: teamTwo)
    }
  }
  
  /*
   Determine if Team2 won the Head2Head
   by committing a foul.
   Otherwise, it takes the ball back.
   */
  func handleSkillPowerWin(ofTeamTwo teamTwo: PlayingTeam, against teamOne: PlayingTeam) {
    if notAKeeperCommittedFoul(from: teamTwo) {
      foulBy(teamTwo, against: teamOne)
    }
    else {
      ballPossession(teamOne: teamTwo, teamTwo: teamOne, for: .takesBall)
    }
  }
  
  /*
   Determine if Team1 won the Head2Head by committing a foul,
   or if it won against the Keeper, thus scoring a goal.
   Otherwise, it keeps the ball.
   */
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
  
  /*
   Listen for the teams scoring goals
   */
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
  
  // Update the Current Event string
  func updateCurrentEvent(for event: Event, andTeam team: PlayingTeam?) {
    currentEvent = EventHelper.eventString(for: event, andTeam: team)
  }
  
}


// MARK: - Handle Play Events

extension GameSimulation {
  
  /*
   Handle one team winning the ball, and
   the other one losing it
   */
  func ballPossession(teamOne: PlayingTeam, teamTwo: PlayingTeam, for event: Event) {
    updateCurrentEvent(for: event, andTeam: teamOne)
    teamTwo.fallBackPosition(against: teamOne.currentPosition)
    teamOne.nextPosition()

    nextBattle(teamOne, vs: teamTwo, andWait: 1)
  }
  
  // Handle a team scoring a goal
  func goalScoring(from teamOne: PlayingTeam, against teamTwo: PlayingTeam) {
    updateCurrentEvent(for: .goal, andTeam: teamOne)
    
    teamTwo.nextPosition()
    teamOne.updateGoals()

    gameState = .goalScored
    
    nextBattle(teamTwo, vs: teamOne, andWait: 2)
  }
  
  // Keep the game going after a certain waiting time
  func nextBattle(_ teamOne: PlayingTeam, vs teamTwo: PlayingTeam, andWait time: TimeInterval) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
      self.battle(teamOne, vs: teamTwo)
    }
  }
  
}


// MARK: - Handle Fouls

extension GameSimulation {
  
  // Handle a foul committed by Team1 on Team2
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
  
  /*
   Check that the player that committed the foul
   is not a Goal Keeper
   */
  func notAKeeperCommittedFoul(from team: PlayingTeam) -> Bool {
    return team.commitedFoul() && !team.isGoalKeeper
  }
  
}

