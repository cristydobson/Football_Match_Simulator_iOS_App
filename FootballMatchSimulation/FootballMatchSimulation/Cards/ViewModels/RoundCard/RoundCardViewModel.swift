///
/// RoundCardViewModel.swift
///
/// Created by Cristina Dobson
///


import Foundation


class RoundCardViewModel: ObservableObject {
  
  
  // MARK: - Properties
  
  let title: String
  let matches: [Round.Match]
  
  
  // MARK: - Methods
  
  init(title: String, matches: [Round.Match]) {
    self.title = title
    self.matches = matches
  }
  
  // Create a row to display every match in the round
  func createRowViewModels() -> [RoundCardRowViewModel] {
    var viewModels: [RoundCardRowViewModel] = []
    
    for match in matches {
      let viewModel = RoundCardRowViewModel(match: match)
      viewModels.append(viewModel)
    }
    return viewModels
  }
  
}
