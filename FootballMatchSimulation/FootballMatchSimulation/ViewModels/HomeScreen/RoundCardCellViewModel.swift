//
//  RoundCardCellViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation


class RoundCardCellViewModel {
  
     
  // MARK: - Properties
  
  let roundName: String
  let games: [RoundCardRowViewModel]
  
  
  // MARK: - Methods

  init(roundName: String, games: [RoundCardRowViewModel]) {
    self.roundName = roundName
    self.games = games
  }
  
  
  
}
