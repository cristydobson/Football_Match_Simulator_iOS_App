//
//  RoundCardRowViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


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
  
  func teamName(at index: Int) -> String {
    return match.teams[index].name
  }
  
  func teamImage(at index: Int) -> UIImage? {
    let name = match.teams[index].image_name
    return ImageHelper.getImage(name)
  }
  
  func teamScore(at index: Int) -> String {
    if match.scores.count > 0 {
      return "\(match.scores[index])"
    }
    return "0"
  }
  
  func scoreLabelColor() -> UIColor {
    let color: UIColor = match.scores.count > 0 ? .white : .dimmedWhite
    return color
  }
  
}
