///
/// RoundGameCellViewModel.swift
///
/// The ViewModel for RoundGameCell.
///
/// Created by Cristina Dobson
///


import Foundation
import UIKit


class RoundGameCellViewModel {
  
  
  // MARK: - Properties
  
  let match: Round.Match
  
  
  // MARK: - Methods
  
  init(match: Round.Match) {
    self.match = match
  }

  // Create the ViewModel for a GameCard
  func createGameCardViewModel() -> GameRoundCardViewModel {
    return GameRoundCardViewModel(match: match)
  }
  
}
