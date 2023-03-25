//
//  RoundGeneratorTests.swift
//  FootballMatchSimulationTests
//
//  Created by Cristina Dobson on 3/25/23.
//


import XCTest
@testable import FootballMatchSimulation


final class RoundGeneratorTests: XCTestCase {

    
  var sut: RoundGenerator!
  var teams: [Team]!
  
  
  // MARK: - Setup Methods
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    sut = RoundGenerator()
    teams = loadTeams()
  }
  
  override func tearDownWithError() throws {
    teams = nil
    sut = nil
    
    try super.tearDownWithError()
  }
  
  
  // MARK: - Helper Methods
  
  func loadTeams() -> [Team] {
    
    if let teams = try? MockDataLoader.loadDataFromBundle([Team].self, from: "TestTeams") {
      return teams
    }
    return []
  }
  
  
  // MARK: - Test Get Rounds
  
  func testGetRounds_whenFourTeamsGiven_thenGetThreeRounds() {
    // given
    let newTeams = teams!
    
    // when
    let rounds = sut.getRounds(from: newTeams)
    
    // then
    XCTAssertTrue(rounds.count == 3)
  }
  
  func testGetRounds_whenFourTeamsGiven_onFirstRound() {
    // given
    let newTeams = teams!
    
    // when
    let rounds = sut.getRounds(from: newTeams)
    
    // then
    let firstRound = rounds.first!
    XCTAssertTrue(firstRound.matches.count == 2)
    
    // First Match --> Team1 vs. Team4
    let match1Teams: [Team] = firstRound.matches[0].teams
    XCTAssertEqual(match1Teams.first!.id, newTeams.first!.id)
    XCTAssertEqual(match1Teams.last!.id, newTeams.last!.id)
    
    // Seconod Match --> Team2 vs. Team3
    let match2Teams: [Team] = firstRound.matches[1].teams
    XCTAssertEqual(match2Teams.first!.id, newTeams[1].id)
    XCTAssertEqual(match2Teams.last!.id, newTeams[2].id)
  }
  
  func testGetRounds_whenFourTeamsGiven_onSecondRound() {
    // given
    let newTeams = teams!
    
    // when
    let rounds = sut.getRounds(from: newTeams)
    
    // then
    let secondRound = rounds[1]
    XCTAssertTrue(secondRound.matches.count == 2)
    
    // First Match --> Team3 vs. Team4
    let match1Teams: [Team] = secondRound.matches[0].teams
    XCTAssertEqual(match1Teams.first!.id, newTeams[2].id)
    XCTAssertEqual(match1Teams.last!.id, newTeams.last!.id)
    
    // Seconod Match --> Team2 vs. Team1
    let match2Teams: [Team] = secondRound.matches[1].teams
    XCTAssertEqual(match2Teams.first!.id, newTeams[1].id)
    XCTAssertEqual(match2Teams.last!.id, newTeams.first!.id)
  }
  
  func testGetRounds_whenFourTeamsGiven_onThirdRound() {
    // given
    let newTeams = teams!
    
    // when
    let rounds = sut.getRounds(from: newTeams)
    
    // then
    let thirdRound = rounds.last!
    XCTAssertTrue(thirdRound.matches.count == 2)
    
    // First Match --> Team4 vs. Team2
    let match1Teams: [Team] = thirdRound.matches[0].teams
    XCTAssertEqual(match1Teams.first!.id, newTeams.last!.id)
    XCTAssertEqual(match1Teams.last!.id, newTeams[1].id)
    
    // Seconod Match --> Team1 vs. Team3
    let match2Teams: [Team] = thirdRound.matches[1].teams
    XCTAssertEqual(match2Teams.first!.id, newTeams.first!.id)
    XCTAssertEqual(match2Teams.last!.id, newTeams[2].id)
  }
  
  

}
