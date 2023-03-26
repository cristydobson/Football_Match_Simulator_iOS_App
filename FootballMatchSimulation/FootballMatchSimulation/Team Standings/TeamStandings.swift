///
/// TeamStandings.swift
///
/// Calculates Team.Standings
///
/// Created by Cristina Dobson
///


import Foundation


class TeamStandings {
  

  // MARK: - Reset Team Standings
  
  /*
   Wipe clean all Teams standings before recalculating
   them after a Match has been replayed
   */
  static func resetStandings(for teams: [Team]) {
    for team in teams {
      team.standings.reset()
    }
  }
  
  
  // MARK: - Update Standings
  
  // Update all Teams standings based on every Round's outcome
  static func updateTeamStandings(from rounds: [Round]) {
    for round in rounds {
      updateTeamStandings(from: round)
    }
  }
  
  // Update all Teams standings based on every Round.Match's outcome
  static func updateTeamStandings(from round: Round) {
    
    for match in round.matches {
      if match.scores.count > 0 {
        updateTeamStandings(from: match)
      }
    }
  }
  
  // Update the Match.teams standings based on the outcome
  static func updateTeamStandings(from match: Round.Match) {
    
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
  
  // Update Goals For and Against per Team
  static func updateGoals(for team: Team, with scores: [Int]) {
    team.standings.games_played += 1
    team.standings.goals_for += scores[0]
    team.standings.goals_against += scores[1]
  }
  
  // Update Wins and Losses for both Teams
  static func updateWins(for teams: [Team]) {
    teams[0].standings.wins += 1
    teams[1].standings.losses += 1
  }
  
  
  // MARK: - Sort Teams by Standings
  
  // Sort Teams by their Standings
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
          
          /*
           If both Teams have the same Goal_Difference count,
           then compare Goals_For count
           */
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


