///
/// EventHelper.swift
///
/// Created by Cristina Dobson
///


import Foundation

// Game Events
enum Event {
  
  case foul
  case takesBall
  case keepsBall
  case goal
  case halfTime
  case matchFinished
  
  // Game event string
  func string() -> String {
    switch self {
      case .foul:
        return "Foul by "
      case .takesBall:
        return " takes the ball"
      case .keepsBall:
        return " keeps the ball"
      case .goal:
        return "Goal by "
      case .halfTime:
        return "HALF TIME!!!!"
      case .matchFinished:
        return "MATCH FINISHED!!!!"
    }
  }
  
}


struct EventHelper {
  
  // Get a complete Game event string
  static func eventString(for event: Event, andTeam team: PlayingTeam?) -> String {
    switch event {
        
      case .foul:
        return event.string() + team!.name
        
      case .takesBall, .keepsBall:
        return team!.name + "'s " + team!.currentPosition.rawValue + event.string()
        
      case .goal:
        return event.string() + team!.name
        
      case .halfTime, .matchFinished:
        return event.string()
    }
  }
  
}
