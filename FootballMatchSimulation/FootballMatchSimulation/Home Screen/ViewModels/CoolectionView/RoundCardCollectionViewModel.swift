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
    var viewModels: [RoundCardRowViewModel] = []
    
    for match in round.matches {
      let viewModel = buildCardRowCellViewModel(from: match.teams)
      viewModels.append(viewModel)
    }
    
    return RoundCardCellViewModel(
      roundName: round.name, games: viewModels)
  }
  
  func buildCardRowCellViewModel(from teams: [TeamModel]) -> RoundCardRowViewModel {
    let team1 = teams[0]
    let team2 = teams[1]
    
    return RoundCardRowViewModel(
      team1Name: team1.name, team1ImageName: team1.imageName, team1Score: 0,
      team2Name: team2.name, team2ImageName: team2.imageName, team2Score: 0)
  }
  
  
  // MARK: - Helper Methods
  
  func getCellViewModel(at indexPath: IndexPath) -> RoundCardCellViewModel {
    return cellViewModels[indexPath.row]
  }
  
  
}
