//
//  CurrentTeam.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation


protocol CurrentTeam {
  
  
  // MARK: - Properties
  
  var name: String { get }
  var currentPosition: Position { get }
  
  var goals: Int { get }
  
  
  // MARK: - Methods
  
  func updateGoals()
  
  func nextPosition()
  func fallBackPosition(against rivalPosition: Position)
  
  func handleCommittedFoul(_ foulPenalty: FoulPenalty)
  func handleReceivedFoul(_ foulPenalty: FoulPenalty)
  
}






