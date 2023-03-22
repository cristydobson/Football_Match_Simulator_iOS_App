//
//  RoundGameCellViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import UIKit


class RoundGameCellViewModel {
  
  
  // MARK: - Properties
  
  let match: Round.Match
  
  
  // MARK: - Methods
  
  init(match: Round.Match) {
    self.match = match
  }

  func createGameCardViewModel() -> GameRoundCardViewModel {
    return GameRoundCardViewModel(match: match)
  }
  
}
