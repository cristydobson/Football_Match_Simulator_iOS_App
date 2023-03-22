//
//  RoundGamesCollectionViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import Combine


class RoundGamesCollectionViewModel: ObservableObject {
  
  
  // MARK: - Properties
  
  @Published var cellViewModels: [RoundGameCellViewModel] = []
  
  
  // MARK: Load Cell ViewModels
  
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
  
  
}
