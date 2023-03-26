///
/// CurrentTeam.swift
///
/// Required for every Team
/// currently playing
///
/// Created by Cristina Dobson
///


import Foundation


protocol CurrentTeam {
  
  
  // MARK: - Properties
  
  var name: String { get }
  
  // The current position the team is playing
  var currentPosition: Position { get }
  
  var goals: Int { get }
  
  
  // MARK: - Methods
  
  func updateGoals()
  
  /*
   Methods to handle when the players lose
   the Head-to-Head battle for the ball
   */
  func nextPosition()
  func fallBackPosition(against rivalPosition: Position)
  
  /*
   Methods to handle when the players
   commit or receive fouls
   */
  func handleCommittedFoul(_ foulPenalty: FoulPenalty)
  func handleReceivedFoul(_ foulPenalty: FoulPenalty)
  
}






