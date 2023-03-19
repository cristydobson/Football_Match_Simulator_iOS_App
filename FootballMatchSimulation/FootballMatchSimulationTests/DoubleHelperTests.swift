//
//  DoubleHelperTests.swift
//  FootballMatchSimulationTests
//
//  Created by Cristina Dobson on 3/18/23.
//


import XCTest
@testable import FootballMatchSimulation


final class DoubleHelperTests: XCTestCase {

  
  var teams: [Team]!
  
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    teams = try? DataLoader.retrieveData([Team].self, from: "Teams")
  }
  
  override func tearDownWithError() throws {
    teams = nil
    
    try super.tearDownWithError()
  }
  
  
  // MARK: - Helper Methods
  
  func firstTeam() -> Team {
    return teams.first!
  }
  
//  func getSkillPower(for players: [Player]) -> Double {
//    return DoubleHelper.getSkillPower(for: players)
//  }
//
//  func getExpectedSkillPower(from players: [Player], helpedBy neighbors: [Player]) -> Double {
//    let playerPower = getSkillPower(for: players)
//    let midfielderPower = getSkillPower(for: neighbors)/2
//
//    let totalSKillPower = playerPower + midfielderPower
//    return totalSKillPower.rounded(to: 2)
//  }
//
//  func getAthleticDecay(skillPower: Double, decay: Double) -> Double {
//    return DoubleHelper.getAthleticDecay(
//      from: skillPower, decayCoefficient: decay)
//  }
  
  
  // MARK: - Test Double Extension
  
//  func testGetRandomNumber_whenUpperLimitGiven_thenReturnDoubleWithinRange() {
//    // given
//    let upperLimit = 10.0
//    let range = 0.0...upperLimit
//    
//    // when
//    let result = upperLimit.randomNumber()
//    
//    // then
//    XCTAssertTrue(range.contains(result))
//  }
//  
//  
//  // MARK: - Test getSkillPower(for:)
//  
//  func testGetSkillPower_forDefenders() {
//    // given
//    let team = firstTeam()
//    let expectedResult = 7.36
//    
//    // when
//    let result = getSkillPower(for: team.defenders)
//      .rounded(to: 2)
//    
//    // then
//    XCTAssertEqual(result, expectedResult)
//  }
//  
//  func testGetSkillPower_forMidfielders() {
//    // given
//    let team = firstTeam()
//    let expectedResult = 7.29
//    
//    // when
//    let result = getSkillPower(for: team.midfielders)
//      .rounded(to: 2)
//    
//    // then
//    XCTAssertEqual(result, expectedResult)
//  }
//  
//  func testGetSkillPower_forAttackers() {
//    // given
//    let team = firstTeam()
//    let expectedResult = 7.28
//    
//    // when
//    let result = getSkillPower(for: team.attackers)
//      .rounded(to: 2)
//    
//    // then
//    XCTAssertEqual(result, expectedResult)
//  }
//  
//  
//  // MARK: - Test getSkillPower(for:helpedBy:)
//  
//  func testGetSkillPower_whenHelpedByMidfielders_forDefenders() {
//    // given
//    let team = firstTeam()
//    let defenders = team.defenders
//    let midfielders = team.midfielders
//    
//    let expectedResult = getExpectedSkillPower(
//      from: defenders, helpedBy: midfielders)
//    
//    // when
//    let result = DoubleHelper.getSkillPower(
//      for: defenders, helpedBy: midfielders)
//      .rounded(to: 2)
//    
//    // then
//    XCTAssertEqual(result, expectedResult)
//  }
//  
//  func testGetSkillPower_whenHelpedByMidfielders_forAttackers() {
//    // given
//    let team = firstTeam()
//    let attackers = team.attackers
//    let midfielders = team.midfielders
//    
//    let expectedResult = getExpectedSkillPower(
//      from: attackers, helpedBy: midfielders)
//    
//    // when
//    let result = DoubleHelper.getSkillPower(
//      for: attackers, helpedBy: midfielders)
//      .rounded(to: 2)
//    
//    // then
//    XCTAssertEqual(result, expectedResult)
//  }
//  
//  
//  // MARK: - Test Athletic Decay
//  
//  func testGetAthleticDecay_mustReturnPositiveDouble() {
//    // when
//    let result = getAthleticDecay(skillPower: 15.0, decay: 0.085)
//    
//    // then
//    XCTAssertTrue(result >= 0)
//  }
//  
//  func testGetAthleticDecayOverTime_whenEachPlayEqualsOneMinute() {
//    // given
//    let athleticDecay = getAthleticDecay(
//      skillPower: 15.0, decay: 0.085)
//    let plays = 90
//    let expectedResult = athleticDecay * Double(plays)
//    
//    // when
//    let result = DoubleHelper.getAthleticDecayOverTime(
//      plays, decay: athleticDecay)
//    
//    // then
//    XCTAssertTrue(result >= expectedResult)
//  }

}
