///
/// PlayerPosition.swift
///
/// Keep track of a Player's position
/// during gameplay.
///
/// Created by Cristina Dobson


import Foundation


// MARK: - Position Types

enum Position: String {
  case keeper
  case defender
  case midfielder
  case attacker
}


// MARK: - Win Head to Head battle

/*
 If the Player wins the Head2Head, then the ball
 is passed to the Player ahead in the field
 */
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

/*
 If the Player loses the Head2Head, then the Player
 trying to recover the ball is further back in the field
 */
extension Position {
  
  func fallbackPosition(against rivalPosition: Position) -> Self {
    switch (self, rivalPosition) {
        
      case (.keeper, _):
        return .defender
        
      case (.defender, _):
        return .keeper
        
      case (.midfielder, _):
        return .defender
        
      /*
       If the Attacker lost against a Defender,
       then they both move to the midfield.
       */
      case (.attacker, .defender):
        return .midfielder
        
      /*
       If the Attacker lost against the Goal Keeper,
       then the Attacker will keep trying to recover
       the ball from the Defender.
       */
      case (.attacker, .keeper):
        return .attacker
        
      // Not a case
      default:
        return self
    }
  }
  
}





















