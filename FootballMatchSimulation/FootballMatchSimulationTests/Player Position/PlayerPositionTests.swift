//
//  PlayerPositionTests.swift
//  FootballMatchSimulationTests
//
//  Created by Cristina Dobson on 3/18/23.
//

import XCTest
@testable import FootballMatchSimulation


final class PlayerPositionTests: XCTestCase {
  
  
  override func setUpWithError() throws {
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }
  
  
  // MARK: - Get Next Player Position
  
  func testGetNextPosition_whenCurrentPositionDefender_thenReturnMidfielder() {
    
    // given
    let currentPosition = Position.defender
    let expectedPosition = Position.midfielder
    
    // when
    let newPosition = currentPosition.nextPosition()
    
    // then
    XCTAssertEqual(newPosition, expectedPosition)
  }
  
  func testGetNextPosition_whenCurrentPositionMidfielder_thenReturnAttacker() {
    
    // given
    let currentPosition = Position.midfielder
    let expectedPosition = Position.attacker
    
    // when
    let newPosition = currentPosition.nextPosition()
    
    // then
    XCTAssertEqual(newPosition, expectedPosition)
  }
  
  func testGetNextPosition_whenCurrentPositionAttacker_thenReturnAttacker() {
    
    // given
    let currentPosition = Position.attacker
    let expectedPosition = Position.attacker
    
    // when
    let newPosition = currentPosition.nextPosition()
    
    // then
    XCTAssertEqual(newPosition, expectedPosition)
  }
  
  func testGetNextPosition_whenCurrentPositionKeeper_thenReturnDefender() {
    
    // given
    let currentPosition = Position.attacker
    let expectedPosition = Position.attacker
    
    // when
    let newPosition = currentPosition.nextPosition()
    
    // then
    XCTAssertEqual(newPosition, expectedPosition)
  }
  
  
  // MARK: - Get Fallback Player Position
  
  func testGetFallbackPosition_whenCurrentPositionKeeper_thenReturnDefender() {
    
    // given
    let currentPosition = Position.keeper
    let anyRivalPosition = Position.attacker
    let expectedPosition = Position.defender
    
    // when
    let newPosition = currentPosition.fallbackPosition(against: anyRivalPosition)
    
    // then
    XCTAssertEqual(newPosition, expectedPosition)
  }
  
  func testGetFallbackPosition_whenCurrentPositionDefender_thenReturnKeeper() {
    
    // given
    let currentPosition = Position.defender
    let anyRivalPosition = Position.attacker
    let expectedPosition = Position.keeper
    
    // when
    let newPosition = currentPosition.fallbackPosition(against: anyRivalPosition)
    
    // then
    XCTAssertEqual(newPosition, expectedPosition)
  }
  
  func testGetFallbackPosition_whenCurrentPositionMidfielder_thenReturnDefender() {
    
    // given
    let currentPosition = Position.midfielder
    let anyRivalPosition = Position.midfielder
    let expectedPosition = Position.defender
    
    // when
    let newPosition = currentPosition.fallbackPosition(against: anyRivalPosition)
    
    // then
    XCTAssertEqual(newPosition, expectedPosition)
  }
  
  func testGetFallbackPosition_whenCurrentPositionAttackerVsDefender_thenReturnMidfielder() {
    // given
    let currentPosition = Position.attacker
    let anyRivalPosition = Position.defender
    let expectedPosition = Position.midfielder
    
    // when
    let newPosition = currentPosition.fallbackPosition(against: anyRivalPosition)
    
    // then
    XCTAssertEqual(newPosition, expectedPosition)
    
  }
  
  func testGetFallbackPosition_whenCurrentPositionAttackerVsKeeper_thenReturnAttacker() {
    // given
    let currentPosition = Position.attacker
    let anyRivalPosition = Position.keeper
    let expectedPosition = Position.attacker
    
    // when
    let newPosition = currentPosition.fallbackPosition(against: anyRivalPosition)
    
    // then
    XCTAssertEqual(newPosition, expectedPosition)
    
  }
  
}
