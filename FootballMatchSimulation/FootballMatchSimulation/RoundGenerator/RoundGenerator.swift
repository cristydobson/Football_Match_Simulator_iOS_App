//
//  RoundGenerator.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation


class RoundGenerator {
  
  
  // MARK: - Properties
  
  var roundCounter = 0
  
  
  // MARK: - Get Rounds
  
  func getRounds(with teams: [Team]) -> [Round] {
    
    var arrangedTeams = teams
    
    var rounds: [Round] = []
    
    let firstRound = getRound(with: arrangedTeams, shouldGetLast: false)
    rounds.append(firstRound)
    
    let secondRound = getRound(with: arrangedTeams, shouldGetLast: true)
    rounds.append(secondRound)
    
    
    var roundCount = teams.count-3
    
    while roundCount > 0 {
      
      arrangedTeams = reorderTeams(teams)
     
      let newRound = getRound(with: arrangedTeams, shouldGetLast: true)
      rounds.append(newRound)
      
      roundCount -= 1
    }

    return rounds
  }
  
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
  
  func getRound(with teams: [Team], shouldGetLast: Bool) -> Round {
    
    var matches: [Round.Match] = []
    
    func getMatch(from teams: [Team]) {
      
      let last = teams.last!
      var rest = teams
      rest.removeLast()
      
      let nextTeam = shouldGetLast ? rest.last! : rest.first!
      
      let match = getNewMatch(for: [last, nextTeam])
      matches.append(match)
      
      if shouldGetLast { rest.removeLast() }
      else { rest.removeFirst() }
      
      if rest.count > 2 {
        getMatch(from: rest)
      }
      else {
        let lastMatch = getNewMatch(for: rest)
        matches.append(lastMatch)
      }
    }
    
    getMatch(from: teams)
    
    roundCounter += 1
    
    return Round(name: "Round \(roundCounter)", matches: matches)
    
  }
  
  func getNewMatch(for teams: [Team]) -> Round.Match {
    let match = Round.Match()
    match.teams = teams
    match.team_ids = [teams[0].id, teams[1].id]
    return match
  }
  
  
}


