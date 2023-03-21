//
//  MockPlayingTeam.swift
//  FootballMatchSimulationTests
//
//  Created by Cristina Dobson on 3/21/23.
//

import Foundation
@testable import FootballMatchSimulation


class MockedPlayingTeam: PlayingTeam {
  
  
  // MARK: - Current Position
  
  var position: Position = .midfielder
  
  override var currentPosition: Position {
    set {}
    get {
      return position
    }
  }
  
  
  // MARK: - Committed Foul
  
  var isFoul: Bool = true
  
  override func commitedFoul() -> Bool {
    return isFoul
  }

  
}
