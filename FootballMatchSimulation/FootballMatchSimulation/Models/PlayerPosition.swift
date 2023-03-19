//
//  PlayerPosition.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/18/23.
//


import Foundation


enum Position: String {
  case keeper
  case defender
  case midfielder
  case attacker
}


// MARK: - Win Head to Head battle

extension Position {
  
  func nextPosition() -> Self {
    switch self {
      case .defender:
        return .midfielder
      case .midfielder:
        return .attacker
      case .attacker:
        return .attacker
      case .keeper:
        return .defender
    }
  }
  
}


// MARK: - Lose Head to Head battle

extension Position {
  
  func fallbackPosition(against rivalPosition: Position) -> Self {
    switch (self, rivalPosition) {
      case (.keeper, _):
        return .defender
      case (.defender, _):
        return .keeper
      case (.midfielder, _):
        return .defender
      case (.attacker, .defender):
        return .midfielder
      case (.attacker, .keeper):
        return .attacker
      default:
        return self
    }
  }
  
}





















