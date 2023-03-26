//
//  GameSimulationTests.swift
//  FootballMatchSimulationTests
//
//  Created by Cristina Dobson on 3/21/23.
//


import XCTest
@testable import FootballMatchSimulation


final class GameSimulationTests: XCTestCase {

    
  // MARK: - Properties
  
  var sut: GameSimulation!
  var teams: [MockedPlayingTeam]!
  
  // MARK: - Setup Methods
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    teams = loadTeams()
    sut = GameSimulation(homeTeam: teams.first!,
                         visitorTeam: teams.last!)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    teams = nil
    
    try super.tearDownWithError()
  }
  
  
  // MARK: - Helper Methods
  
  func loadTeams() -> [MockedPlayingTeam] {
    var playingTeams: [MockedPlayingTeam] = []
    
    if let teams = try? MockDataLoader.loadDataFromBundle([Team].self, from: "TestTeams") {

      for team in teams {
        let playingTeam = MockedPlayingTeam(team: team)
        playingTeams.append(playingTeam)
      }
      return playingTeams
    }
    return []
  }
  
  func getEventString(for event: Event, andTeam team: MockedPlayingTeam?) -> String {
    return EventHelper.eventString(for: event, andTeam: team)
  }
  
  
  // MARK: - Test Start Simulation
  
  func testStartFirstTimeSimulation_thenGameStateIsInProgress() {
    // when
    sut.startFirstHalfSimulation()
    
    // then
    XCTAssertTrue(sut.gameState == .inProgress)
  }
  
  func testStartFirstTimeSimulation_thenPlaysEqualOne() {
    // when
    sut.startFirstHalfSimulation()
    
    // then
    XCTAssertTrue(sut.plays == 1)
  }
  
  func testStartSecondTimeSimulation_afterHalfTime_thenGameStateIsInProgress() {
    // when
    sut.startSecondHalfSimulation()
    
    // then
    XCTAssertTrue(sut.gameState == .inProgress)
  }
  
  func testStartSecondTimeSimulation_afterHalfTime_thenPlaysEqualOne() {
    /*
     During run time, Plays = 45+1.
     */
    
    // when
    sut.startSecondHalfSimulation()
    
    // then
    XCTAssertTrue(sut.plays == 1)
  }
  
  
  // MARK: - Test in-Progress Game State
  
  func testHandleSkillPowerWinOfTeamTwo_whenPlayerCommittedFoulAndNotKeeperPosition() {
    // given
    let team1 = teams.first!
    let team2 = teams.last!
    team2.resetPosition()
    
    // when
    sut.handleSkillPowerWin(ofTeamTwo: team2, against: team1)
    
    // then
    let expectedEventString = getEventString(for: .foul, andTeam: team2)
    XCTAssertEqual(sut.currentEvent, expectedEventString)
    
  }
  
  func testHandleSkillPowerWinOfTeamTwo_whenPlayerDidNotCommitAFoul() {
    // given
    let team1 = teams.first!
    let team2 = teams.last!
    team2.isFoul = false
    
    // when
    sut.handleSkillPowerWin(ofTeamTwo: team2, against: team1)
    
    // then
    let expectedEventString = getEventString(for: .takesBall, andTeam: team2)
    XCTAssertEqual(sut.currentEvent, expectedEventString)
        
    let expectation = expectation(description: "Plays == 1")
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
      XCTAssertTrue(self.sut.plays == 1)
      expectation.fulfill()
    })
    
    wait(for: [expectation], timeout: 2.0)
  }
  
  
  func testHandleSkillPowerWinOfTeamOne_whenOpponentIsGoalKeeper_thenScoreGoal() {
    // given
    let team1 = teams.first!
    let team2 = teams.last!
    team2.position = .keeper
    
    // when
    sut.handleSkillPowerWin(ofTeamOne: team1, against: team2)
    
    // then
    let expectedEventString = getEventString(for: .goal, andTeam: team1)
    XCTAssertEqual(sut.currentEvent, expectedEventString)
        
    let expectation = expectation(description: "Plays == 1")
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
      XCTAssertTrue(self.sut.plays == 1)
      expectation.fulfill()
    })
    
    wait(for: [expectation], timeout: 4.0)
  }
  
  
  
  // MARK: - Test Half-Time Game State
  
  func testHandleHalfTime_thenPlaysEqualOne() {
    /*
     During run time, Plays = 45+1.
     */
    
    // when
    sut.handleHalfTime()
    
    let expectedEventString = getEventString(for: .halfTime, andTeam: nil)
    XCTAssertEqual(sut.currentEvent, expectedEventString)
    
    XCTAssertTrue(sut.gameState == .halfTime)
    
    let expectation = expectation(description: "Plays == 1")
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
      
      // then
      XCTAssertTrue(self.sut.plays == 1)
      
      expectation.fulfill()
    })
    
    wait(for: [expectation], timeout: 3.0)
    
  }
  
  
  // MARK: - Test Finished Match Game State
  
  func testHandleFinishedMatch_thenGameStateIsFinished() {
    // given
    let team1 = teams.first!
    let team2 = teams.last!
    
    // when
    sut.handleFinishedMatch(for: team1, vs: team2)
    
    // then
    XCTAssertTrue(sut.gameState == .finished)
    
    let expectedEventString = getEventString(for: .matchFinished, andTeam: nil)
    XCTAssertEqual(sut.currentEvent, expectedEventString)
  }
  

}
