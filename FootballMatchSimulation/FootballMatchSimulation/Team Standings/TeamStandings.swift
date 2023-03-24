//
//  TeamStandings.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/24/23.
//


import Foundation


class TeamStandings {
  

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
      if match.scores.count > 0 {
        updateStandings(for: match)
      }
    }
  }
  
  static func updateStandings(for match: Round.Match) {
    
    let team1Goals = match.scores[0]
    let team2Goals = match.scores[1]
    
    let team1 = match.teams[0]
    let team2 = match.teams[1]
    
    updateGoals(for: team1, with: [team1Goals, team2Goals])
    updateGoals(for: team2, with: [team2Goals, team1Goals])
    
    if team1Goals > team2Goals {
      updateWins(for: [team1, team2])
    }
    else if team1Goals < team2Goals {
      updateWins(for: [team2, team1])
    }
    else {
      [team1, team2].forEach {
        $0.standings.draws += 1
      }
    }
  }
  
  static func updateGoals(for team: Team, with scores: [Int]) {
    team.standings.games_played += 1
    team.standings.goals_for += scores[0]
    team.standings.goals_against += scores[1]
  }
  
  static func updateWins(for teams: [Team]) {
    teams[0].standings.wins += 1
    teams[1].standings.losses += 1
  }
  
  
  // MARK: - Sort Teams by Standings
  
  static func sortTeamsByStandings(_ teams: [Team]) -> [Team] {
    var sortedTeams = teams
    
    sortedTeams.sort {
      
      // If teams have same Points count
      if $0.standings.points == $1.standings.points {
        
        // Check Goal_Difference count
        if $0.standings.goalsDifference > $1.standings.goalsDifference {
          return $0.standings.goalsDifference > $1.standings.goalsDifference
        }
        else if $0.standings.goalsDifference == $1.standings.goalsDifference {
          
          // Check Goals_For count
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


