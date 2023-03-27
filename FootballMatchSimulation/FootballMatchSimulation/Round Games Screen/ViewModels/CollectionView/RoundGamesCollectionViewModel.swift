///
/// RoundGamesCollectionViewModel.swift
///
/// The ViewModel for RoundGamesCollectionView.
///
/// Created by Cristina Dobson
///


import Foundation
import Combine


class RoundGamesCollectionViewModel: ObservableObject {
  
  
  // MARK: - Properties
  
  @Published var cellViewModels: [RoundGameCellViewModel] = []
  
  
  // MARK: Load Cell ViewModels
  
  /*
   Create the cellViewModels containing
   the matches for the current round
   */
  func loadCellViewModels(from round: Round) {
    cellViewModels = createCellViewModels(from: round)
  }
  
  func createCellViewModels(from round: Round) -> [RoundGameCellViewModel] {
    var viewModels: [RoundGameCellViewModel] = []
    
    for match in round.matches {
      let viewModel = RoundGameCellViewModel(match: match)
      viewModels.append(viewModel)
    }
    return viewModels
  }
  
  
  // MARK: - Helper Methods
  
  func getCellViewModel(at indexPath: IndexPath) -> RoundGameCellViewModel {
    return cellViewModels[indexPath.row]
  }
  
  // Update the Match model after the game has been played
  func setNewGameScore(_ scores: [Int], at indexPath: IndexPath) {
    let viewModel = cellViewModels[indexPath.row]
    viewModel.match.gameIsPlayed = true
    viewModel.match.scores = scores
  }
  
}
