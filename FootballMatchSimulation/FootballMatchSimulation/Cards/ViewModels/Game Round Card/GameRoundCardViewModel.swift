///
/// GameRoundCardViewModel.swift
///
/// Created by Cristina Dobson
///


import Foundation
import UIKit


class GameRoundCardViewModel {
  
  
  // MARK: - Properties
  
  let match: Round.Match!
  
  
  // MARK: - Methods
  
  init(match: Round.Match!) {
    self.match = match
  }
  
  // Get the names of the teams
  func teamName(at index: Int) -> String {
    return match.teams[index].name
  }
  
  // Get the logos of the teams
  func teamImage(at index: Int) -> UIImage? {
    let name = match.teams[index].image_name
    return ImageHelper.getImage(name)
  }
  
  // Get the scores of the teams
  func teamsFinalScore() -> String {
    return "\(match.scores[0]) - \(match.scores[1])"
  }
  
}
