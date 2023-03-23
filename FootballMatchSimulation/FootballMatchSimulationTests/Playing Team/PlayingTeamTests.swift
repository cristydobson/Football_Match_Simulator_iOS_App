//
//  PlayingTeamTests.swift
//  FootballMatchSimulationTests
//
//  Created by Cristina Dobson on 3/19/23.
//


import XCTest
@testable import FootballMatchSimulation


final class PlayingTeamTests: XCTestCase {

  
  // MARK: - Properties
    
  var sut: PlayingTeam!
  var teams: [Team]!
  
  
  // MARK: - Setup Methods
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    let fileName = JsonFileName.teams.rawValue
    teams = try? DataLoader.retrieveData([Team].self, from: fileName)
    sut = PlayingTeam(team: firstTeam())
  }
  
  override func tearDownWithError() throws {
    sut = nil
    teams = nil
    
    try super.tearDownWithError()
  }
  
  
  // MARK: - Helper Methods
  
  func firstTeam() -> Team {
    return teams.first!
  }
  
  
  // MARK: - Test Update Goals
  
  func testUpdateGoals_whenScoring_thenIncrementByOne() {
    // given
    let expectedResult = 1
    
    // when
    sut.updateGoals()
    let result = sut.goals
    
    // then
    XCTAssertEqual(result, expectedResult)
  }
  
  
  // MARK: - Test Getting Field Position
  
  func testGetNextPosition_whenCurrentPositionMidfielder_thenReturnAttacker() {
    // given
    let expectedPosition: Position = .attacker
    
    // when
    sut.nextPosition()
    let currentPosition = sut.currentPosition
    
    // then
    XCTAssertEqual(currentPosition, expectedPosition)
    
  }
  
  func testGetFallbackPosition_whenCurrentPositionMidfielder_thenReturnDefender() {
    // given
    let expectedPosition: Position = .defender
    
    // when
    sut.fallBackPosition(against: .midfielder)
    let currentPosition = sut.currentPosition
    
    // then
    XCTAssertEqual(currentPosition, expectedPosition)
    
  }
  
  
  // MARK: - Test Get SkillPower
  
  func testGetPlayersSkillPower_whenCurrentPositionMidfielders_thenIncrementMidfieldersPlaysByOne() {
    // when
    let _ = sut.playersSkillPower()
    
    // then
    XCTAssertTrue(sut.players.positionPlays.getPlays(for: .midfielder) == 1)
  }
  
  func testGetPlayersSkillPower_returnsPositiveNonZeroDouble() {
    // when
    let result = sut.playersSkillPower()
    
    // then
    XCTAssertTrue(result > 0)
  }
  
  
  // MARK: - Test Handle Committed Fouls
  
  func testHandleCommittedFoul_whenYellowCard_forMidfielderPosition() {
    // when
    sut.handleCommittedFoul(.yellowCard)
    
    // then
    XCTAssertTrue(sut.players.yellowCards.midFielderCount == 1)
    XCTAssertTrue(!sut.players.yellowCards.isExpulsion(for: .midfielder))
  }
  
  func testHandleCommittedFoul_whenTwoYellowCards_forMidfielderPosition() {
    // given
    let midfielderCount = sut.players.midfielders.count
    let expectedMidfielderCount = midfielderCount - 1
    
    // when
    sut.handleCommittedFoul(.yellowCard)
    sut.handleCommittedFoul(.yellowCard)
    let currentMidfielderCount = sut.players.midfielders.count
    
    // then
    XCTAssertTrue(sut.players.yellowCards.midFielderCount == 2)
    XCTAssertTrue(sut.players.yellowCards.isExpulsion(for: .midfielder))
    XCTAssertEqual(currentMidfielderCount, expectedMidfielderCount)
  }
  
  func testHandleCommittedFoul_whenRedCard_forMidfielderPosition() {
    // given
    let midfielderCount = sut.players.midfielders.count
    let expectedMidfielderCount = midfielderCount - 1
    
    // when
    sut.handleCommittedFoul(.redCard)
    let currentMidfielderCount = sut.players.midfielders.count
    
    // then
    XCTAssertEqual(currentMidfielderCount, expectedMidfielderCount)
  }
  
  
  // MARK: - Test Handle Received Fouls
  
  func testHandleReceivedFoul_whenYellowCard_thenIncreaseAthleticDecay() {
    // given
    let expectedResult = 0.025 + 0.002
    
    // when
    sut.handleReceivedFoul(.yellowCard)
    let result = sut.players.athleticDecay.athleticDecayCoefficient
    
    // then
    XCTAssertEqual(result, expectedResult)
    
  }
  
  func testHandleReceivedFoul_whenRedCard_thenIncreaseAthleticDecay() {
    // given
    let expectedResult = 0.025 + 0.003
    
    // when
    sut.handleReceivedFoul(.redCard)
    let result = sut.players.athleticDecay.athleticDecayCoefficient
    
    // then
    XCTAssertEqual(result, expectedResult)
    
  }
  
  func testHandleReceivedFoul_whenNoCardGiven_thenIncreaseAthleticDecay() {
    // given
    let expectedResult = 0.025 + 0.001
    
    // when
    sut.handleReceivedFoul(.freeKick)
    let result = sut.players.athleticDecay.athleticDecayCoefficient
    
    // then
    XCTAssertEqual(result, expectedResult)
    
  }
  
  
  // MARK: - Remove Players
  
  func testRemovePlayer_fromDefendersArray() {
    // given
    let expectedCount = sut.players.defenders.count - 1
    
    // when
    sut.players.removePlayer(from: .defender)
    let count = sut.players.defenders.count
    
    // then
    XCTAssertEqual(count, expectedCount)
  }
  
  func testRemovePlayer_fromAttackersArray() {
    // given
    let expectedCount = sut.players.attackers.count - 1
    
    // when
    sut.players.removePlayer(from: .attacker)
    let count = sut.players.attackers.count
    
    // then
    XCTAssertEqual(count, expectedCount)
  }
  

}
