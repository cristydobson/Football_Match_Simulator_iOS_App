//
//  TeamStandingsTests.swift
//  FootballMatchSimulationTests
//
//  Created by Cristina Dobson on 3/25/23.
//


import XCTest
@testable import FootballMatchSimulation


final class TeamStandingsTests: XCTestCase {

  
  var teams: [Team]!
  var rounds: [Round]!
  
  
  // MARK: - Setup Methods
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    teams = loadTeams()
    rounds = loadRounds()
  }
  
  override func tearDownWithError() throws {
    teams = nil
    rounds = nil
    
    try super.tearDownWithError()
  }
  
  
  // MARK: - Helper Methods
  func loadTeams() -> [Team] {

    if let teams = try? MockDataLoader.loadDataFromBundle([Team].self, from: "TestTeams") {
      return teams
    }
    return []
  }
  
  func loadRounds() -> [Round] {

    if let rounds = try? MockDataLoader.loadDataFromBundle([Round].self, from: "TestRounds") {
      return rounds
    }
    return []
  }
  
  func buildMatch(with scores: [Int]) -> Round.Match {
    let round = rounds.first!
    
    let match = round.matches.first!
    match.teams = [teams[0], teams[1]]
    match.scores = scores
    
    return match
  }
  
  func addStandingsToTeams() -> [Team] {
    
    let team1 = teams[0]
    team1.standings.wins = 1
    team1.standings.wins = 1
    team1.standings.goals_for = 4
    team1.standings.goals_against = 1
    
    let team2 = teams[1]
    team2.standings.wins = 1
    team2.standings.draws = 1
    team2.standings.goals_for = 2
    team2.standings.goals_against = 4
    
    let team3 = teams[2]
    team3.standings.wins = 1
    team3.standings.draws = 1
    team3.standings.goals_for = 2
    team3.standings.goals_against = 3
    
    return [team1, team2, team3]
  }
  
  
  // MARK: - Test Reset Teams Standings
  
  func testResetStandings_thenStandingsValuesEqualZero() {
    // given
    let team = teams.first!
    team.standings.wins = 1
    team.standings.draws = 1
    team.standings.losses = 1
    team.standings.goals_for = 1
    team.standings.goals_against = 1
    team.standings.points = 4
    team.standings.games_played = 3
    
    // when
    TeamStandings.resetStandings(for: [team])
    
    // then
    XCTAssertTrue(team.standings.wins == 0)
    XCTAssertTrue(team.standings.draws == 0)
    XCTAssertTrue(team.standings.losses == 0)
    XCTAssertTrue(team.standings.goals_for == 0)
    XCTAssertTrue(team.standings.goals_against == 0)
    XCTAssertTrue(team.standings.goalsDifference == 0)
    XCTAssertTrue(team.standings.points == 0)
    XCTAssertTrue(team.standings.games_played == 0)
  }
  
  
  // MARK: - Test Update Standings
  
  func testUpdateTeamStandings_whenPlayedMatchGiven() {
    // given
    let scores = [1, 2]
    let match = buildMatch(with: scores)
    
    let team1 = match.teams.first!
    let team2 = match.teams.last!
    team1.standings.reset()
    team2.standings.reset()
    
    // when
    TeamStandings.updateTeamStandings(from: match)
    
    // then
    
    // TEAM 1
    XCTAssertTrue(team1.standings.wins == 0)
    XCTAssertTrue(team1.standings.draws == 0)
    XCTAssertTrue(team1.standings.losses == 1)
    XCTAssertTrue(team1.standings.goals_for == 1)
    XCTAssertTrue(team1.standings.goals_against == 2)
    XCTAssertTrue(team1.standings.goalsDifference == -1)
    XCTAssertTrue(team1.standings.points == 0)
    XCTAssertTrue(team1.standings.games_played == 1)
    
    // TEAM 2
    XCTAssertTrue(team2.standings.wins == 1)
    XCTAssertTrue(team2.standings.draws == 0)
    XCTAssertTrue(team2.standings.losses == 0)
    XCTAssertTrue(team2.standings.goals_for == 2)
    XCTAssertTrue(team2.standings.goals_against == 1)
    XCTAssertTrue(team2.standings.goalsDifference == 1)
    XCTAssertTrue(team2.standings.points == 3)
    XCTAssertTrue(team2.standings.games_played == 1)
    
  }
    
  func testSortTeamsByStandings() {
    // given
    let newTeams = addStandingsToTeams()
    
    // when
    let sortedTeams = TeamStandings.sortTeamsByStandings(newTeams)
    
    // then
    XCTAssertEqual(sortedTeams[0].standings.points, 6)
    XCTAssertEqual(sortedTeams[1].standings.points, 4)
    XCTAssertEqual(sortedTeams[2].standings.points, 4)
    
    XCTAssertEqual(sortedTeams[0].standings.goalsDifference, 3)
    XCTAssertEqual(sortedTeams[1].standings.goalsDifference, -1)
    XCTAssertEqual(sortedTeams[2].standings.goalsDifference, -2)

  }

}
