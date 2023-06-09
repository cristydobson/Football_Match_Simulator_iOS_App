///
/// StandingsCardRowViewModel.swift
///
/// Created by Cristina Dobson
///


import Foundation
import UIKit


class StandingsCardRowViewModel {
  
  
  enum Score {
    case gamesPlayed
    case wins, draws, losses
    case goalsFor
    case goalsAgainst
    case goalsDifference
    case points
  }
  
  
  // MARK: - Properties
  
  let team: Team
  let position: Int
  
  let standings: Team.Standings
  
  var positionString: String {
    return "\(position)"
  }
  
  
  // MARK: - Methods
  
  init(team: Team, position: Int) {
    self.team = team
    self.position = position
    standings = team.standings
  }
  
  // Get the logo of every team
  func teamImage() -> UIImage? {
    let name = team.image_name
    return ImageHelper.getImage(name)
  }
  
  // Get the standings of every team
  func getString(for score: Score) -> String {
    switch score {
      case .gamesPlayed:
        return "\(standings.games_played)"
      case .wins:
        return "\(standings.wins)"
      case .draws:
        return "\(standings.draws)"
      case .losses:
        return "\(standings.losses)"
      case .goalsFor:
        return "\(standings.goals_for)"
      case .goalsAgainst:
        return "\(standings.goals_against)"
      case .goalsDifference:
        return "\(standings.goalsDifference)"
      case .points:
        return "\(standings.points)"
    }
  }
  
}











