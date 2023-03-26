///
/// RoundCardCollectionViewModel.swift
///
/// The CollectionView displaying every
/// Round in the tournament.
///
/// Created by Cristina Dobson
///


import Foundation
import Combine


class RoundCardCollectionViewModel: ObservableObject {
  
  
  // MARK: - Properties
  
  @Published var cellViewModels: [RoundCardCellViewModel] = []
    
  
  // MARK: Load Cell ViewModels
  
  // Create new Cell ViewModels
  func loadCellViewModels(from rounds: [Round]) {
    var viewModels: [RoundCardCellViewModel] = []
    
    for round in rounds {
      let viewModel = createCellViewModel(from: round)
      viewModels.append(viewModel)
    }
    
    cellViewModels = viewModels
  }
  
  func createCellViewModel(from round: Round) -> RoundCardCellViewModel {
    return RoundCardCellViewModel(roundName: round.name, matches: round.matches)
  }
  
  
  // MARK: - Helper Methods
  
  // Get a single Cell ViewModel
  func getCellViewModel(at indexPath: IndexPath) -> RoundCardCellViewModel {
    return cellViewModels[indexPath.row]
  }
  
}
