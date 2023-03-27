///
/// RoundCardRowViewModel.swift
///
/// Created by Cristina Dobson
///


import Foundation
import UIKit


class RoundCardRowViewModel {
  
  
  // MARK: - Properties
  
  let match: Round.Match
  
  
  // MARK: Methods

  init(match: Round.Match) {
    self.match = match
  }
  
  
  // MARK: - Method Helpers
  
  // Get the team's name
  func teamName(at index: Int) -> String {
    return match.teams[index].name
  }
  
  // Get the team's logo
  func teamImage(at index: Int) -> UIImage? {
    let name = match.teams[index].image_name
    return ImageHelper.getImage(name)
  }
  
  /*
   Get the team's score if the game
   has been played before
   */
  func teamScore(at index: Int) -> String {
    if match.scores.count > 0 {
      return "\(match.scores[index])"
    }
    return "0"
  }
  
  /*
   If the game has never been played,
   the color of the label will be dimmed
   */
  func scoreLabelColor() -> UIColor {
    let color: UIColor = match.scores.count > 0 ? .white : .dimmedWhite
    return color
  }
  
}
