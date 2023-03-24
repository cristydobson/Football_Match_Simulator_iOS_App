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
  let matches: [Round.Match]
  
  
  // MARK: - Methods

  init(roundName: String, matches: [Round.Match]) {
    self.roundName = roundName
    self.matches = matches
  }
  
  func createRoundCardViewModel() -> RoundCardViewModel {
    return RoundCardViewModel(title: roundName, matches: matches)
  }
  
}
