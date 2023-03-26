///
/// RoundGenerator.swift
///
/// Generate tournament Rounds for an even
/// number of teams.
/// This is done only on first app launch.
///
/// Created by Cristina Dobson
///


import Foundation


class RoundGenerator {
  
       
  // MARK: - Properties
  
  /*
   Keep track of the Rounds
   generated so far
   */
  var roundCounter = 0
  
  
  // MARK: - Get Rounds
  
  /*
   Create N-1 Rounds, where Teams.count = N.
   Every team must play each other once.
   */
  func getRounds(from teams: [Team]) -> [Round] {
    
    var tempTeams = teams
    
    // Rounds created
    var rounds: [Round] = []
    
    /*
     The first and Second Rounds do not require
     a reordered Teams array.
     */
    let firstRound = getRound(with: tempTeams, shouldGetLast: false)
    rounds.append(firstRound)
    
    let secondRound = getRound(with: tempTeams, shouldGetLast: true)
    rounds.append(secondRound)
    
    
    /*
     Consecutive Rounds, do require a reordered Teams array.
     
     (e.g.)
        Reorder Teams[1, 2, 3, 4]
        - The last team has a fixed position.
        - Rotate the other teams clockwise, by moving
        the N-1 team to the front of the queue.
     
        [1, 2, X, 4] --> [X, 1, 2, 4] --> [3, 1, 2, 4]
     */
    
    /*
     Number of Rounds left to create, based on
     the number of teams, minus the 2 first Rounds
     already created above.
     */
    var roundCount = teams.count-3
    
    while roundCount > 0 {
      
      tempTeams = reorderTeams(teams)
     
      let newRound = getRound(with: tempTeams, shouldGetLast: true)
      rounds.append(newRound)
      
      roundCount -= 1
    }

    return rounds
  }
  
  
  // Reorder the Teams array
  func reorderTeams(_ teams: [Team]) -> [Team] {
    var reorderedTeams: [Team] = []
    var tempTeams = teams
    
    let index = tempTeams.count-2
    reorderedTeams.append(tempTeams[index])
    
    tempTeams.remove(at: index)
    reorderedTeams.append(contentsOf: tempTeams)
    
    return reorderedTeams
  }
  
  
  // MARK: - Get Single Round
  
  // Create a single Round
  func getRound(with teams: [Team], shouldGetLast: Bool) -> Round {
    
    var matches: [Round.Match] = []
    
    /*
     Recursive method that keeps creating matches
     as long as there are teams left
     */
    func getMatch(from teams: [Team]) {
      
      // First Team in the Match
      let last = teams.last!
      
      var rest = teams
      rest.removeLast()
      
      // Second Team in the Match
      let nextTeam = shouldGetLast ? rest.last! : rest.first!
      
      // Create the Match
      let match = getNewMatch(for: [nextTeam, last])
      matches.append(match)
      
      /*
       Update the Rest of the teams array, for the
       remaining teams that need a Match
       */
      if shouldGetLast { rest.removeLast() }
      else { rest.removeFirst() }
      
      /*
       If the Rest of the teams array has more than 4 Teams,
       then Recurse through the method,
       otherwise, create a Match with the 2 remaning teams.
       */
      if rest.count > 2 {
        getMatch(from: rest)
      }
      else {
        let lastMatch = getNewMatch(for: rest)
        matches.append(lastMatch)
      }
    }
    
    // Call the nested function
    getMatch(from: teams)
    
    roundCounter += 1
    
    return Round(name: "Round \(roundCounter)", matches: matches)
    
  }
  
  /*
   Create a new Round.Match with the given 2 Teams.
   If a Team has not played home yet, then this
   Team will be the first one in the Match.teams array.
   */
  func getNewMatch(for teams: [Team]) -> Round.Match {
    let match = Round.Match()
    var newTeams: [Team] = teams
    
    if teams[0].standings.hasPlayedHome {
      newTeams = [teams[1], teams[0]]
    }
    
    newTeams[0].standings.hasPlayedHome = true
    
    match.teams = newTeams
    match.team_ids = [newTeams[0].id, newTeams[1].id]
    
    return match
  }
  
}


