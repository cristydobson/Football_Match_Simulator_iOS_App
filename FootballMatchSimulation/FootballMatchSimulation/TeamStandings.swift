//
//  TeamStandings.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/24/23.
//


import Foundation


class TeamStandings {
  
  
  // MARK: - Properties
  
  
  // MARK: - Reset Team Standings
  
  static func resetStandings(for teams: [Team]) {
    for team in teams {
      team.standings.reset()
    }
  }
  
  
  // MARK: - Update Standings
  
  static func updateStandings(for rounds: [Round]) {
    for round in rounds {
      updateStandings(for: round)
    }
  }
  
  static func updateStandings(for round: Round) {
    for match in round.matches {
      updateStandings(for: match)
    }
  }
  
  static func updateStandings(for match: Round.Match) {
    
    if match.scores.count > 0 {
      let team1Goals = match.scores[0]
      let team2Goals = match.scores[1]
      
      match.teams[0].standings.games_played += 1
      match.teams[0].standings.goals_for += team1Goals
      match.teams[0].standings.goals_against += team2Goals
      
      match.teams[1].standings.games_played += 1
      match.teams[1].standings.goals_for += team2Goals
      match.teams[1].standings.goals_against += team1Goals
      
      if team1Goals > team2Goals {
        match.teams[0].standings.wins += 1
        match.teams[1].standings.losses += 1
      }
      else if team1Goals < team2Goals {
        match.teams[0].standings.losses += 1
        match.teams[1].standings.wins += 1
      }
      else {
        match.teams[0].standings.draws += 1
        match.teams[1].standings.draws += 1
      }
    }
    
  }
  
  
  // MARK: - Sort Teams by Standings
  
  static func sortTeamsByStandings(_ teams: [Team]) -> [Team] {
    var sortedTeams = teams
    
    sortedTeams.sort {
      
      if $0.standings.points == $1.standings.points {
        
        if $0.standings.goalsDifference > $1.standings.goalsDifference {
          return $0.standings.goalsDifference > $1.standings.goalsDifference
        }
        else if $0.standings.goalsDifference == $1.standings.goalsDifference {
          
          if $0.standings.goals_for > $1.standings.goals_for {
            return $0.standings.goals_for > $1.standings.goals_for
          }
        }
      }
      return $0.standings.points > $1.standings.points
    }
    
    return sortedTeams
  }
  
  
  
}


