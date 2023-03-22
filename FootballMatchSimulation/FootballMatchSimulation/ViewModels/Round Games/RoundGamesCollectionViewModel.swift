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
      let viewModel = buildCardRowCellViewModel(from: match)
      viewModels.append(viewModel)
    }
    return viewModels
  }
  
  func buildCardRowCellViewModel(from match: Round.Match) -> RoundGameCellViewModel {
    let team1 = match.teams[0]
    let team2 = match.teams[1]
    
    return RoundGameCellViewModel(
      team1Name: team1.name, team1ImageName: team1.imageName,
      team2Name: team2.name, team2ImageName: team2.imageName)
  }
  
  
  
  // MARK: - Helper Methods
  
  func getCellViewModel(at indexPath: IndexPath) -> RoundGameCellViewModel {
    return cellViewModels[indexPath.row]
  }
  
  
}
