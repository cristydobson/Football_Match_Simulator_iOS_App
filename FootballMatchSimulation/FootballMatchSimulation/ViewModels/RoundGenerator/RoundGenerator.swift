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
  
  
  
  func firstRound(with teams: [TeamModel]) -> Round {
    
    var matches: [Round.Match] = []
    
    func getMatch(from teams: [TeamModel]) {
      
      let last = teams.last!
      var rest = teams
      rest.removeLast()
      
      matches.append(Round.Match(teams: [last, rest.first!]))
      rest.removeFirst()
      
      if rest.count > 2 {
        getMatch(from: rest)
      }
      else {
        matches.append(Round.Match(teams: rest))
      }
      
    }
    
    getMatch(from: teams)
    
    
    roundCounter += 1
    
    
    print("ROUND \(roundCounter) ------->\n")
    for m in matches {
      print("\(m.teams[0].name) vs. \(m.teams[1].name)!!!\n")
    }
    
    return Round(name: "Round \(roundCounter)", matches: matches)
    
  }
  
  
  
  func otherRounds(with teams: [TeamModel]) -> Round {
    
    
    var matches: [Round.Match] = []
    
    func getMatch(from teams: [TeamModel]) {
      
      let last = teams.last!
      var rest = teams
      rest.removeLast()
      let next = rest.last!
      
      matches.append(Round.Match(teams: [last, next]))
      rest.removeLast()
      
      if rest.count > 2 {
        getMatch(from: rest)
      }
      else {
        matches.append(Round.Match(teams: rest))
      }
      
    }
    
    
    getMatch(from: teams)
    
    roundCounter += 1
    
    print("ROUND \(roundCounter) ------->\n")
    for m in matches {
      print("\(m.teams[0].name) vs. \(m.teams[1].name)!!!\n")
    }
    
    
    
    return Round(name: "Round \(roundCounter)", matches: matches)
    
  }
  
  
  
  func getRounds(with teams: [TeamModel]) -> [Round] {

    var arrangedTeams = teams

    var rounds: [Round] = []

    let firstRound = firstRound(with: arrangedTeams)
    rounds.append(firstRound)
    
    let secondRound = otherRounds(with: arrangedTeams)
    rounds.append(secondRound)

    var roundCount = teams.count-3
    
    while roundCount > 0 {
      
      arrangedTeams = []
      
      var tempTeams = teams
      
      let index = tempTeams.count-2
      arrangedTeams.append(tempTeams[index])
      
      tempTeams.remove(at: index)
      arrangedTeams.append(contentsOf: tempTeams)
      
      let newRound = otherRounds(with: arrangedTeams)
      rounds.append(newRound)
      
      roundCount -= 1
    }
    
    return rounds
  }
  
  
  
}


