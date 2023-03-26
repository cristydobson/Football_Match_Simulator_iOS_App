///
/// RoundCardCellViewModel.swift
///
/// Cell for every Round
///
/// Created by Cristina Dobson
///


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
  
  /*
   Create a ViewModel for the RoundCard
   being displayed in the cell
   */
  func createRoundCardViewModel() -> RoundCardViewModel {
    return RoundCardViewModel(title: roundName, matches: matches)
  }
  
}
