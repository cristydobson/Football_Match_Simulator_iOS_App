//
//  RoundCardCollectionViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation
import Combine


class RoundCardCollectionViewModel: ObservableObject {
  
  
  // MARK: - Properties
  
  @Published var cellViewModels: [RoundCardCellViewModel] = []
    
  
  // MARK: Load Cell ViewModels
  
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
  
  func getCellViewModel(at indexPath: IndexPath) -> RoundCardCellViewModel {
    return cellViewModels[indexPath.row]
  }
  
  
}
