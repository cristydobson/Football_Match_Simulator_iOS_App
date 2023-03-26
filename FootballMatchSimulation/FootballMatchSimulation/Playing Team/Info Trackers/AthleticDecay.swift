///
/// AthleticDecay.swift
///
/// Calculate the Athletic Decay for
/// the current PlayingTeam's position
///
/// Created by Cristina Dobson
///


import Foundation


final class AthleticDecay {
  
  
  // MARK: - Properties
  
  private(set) var athleticDecayCoefficient = 0.025
  
  
  // MARK: - Methods
  
  // Increase the AthleticDecayCoefficient
  func updateCoefficient(by amount: Double) {
    athleticDecayCoefficient += amount
  }
  
  /*
   Calculate the TotalAthleticDecay over time.
   Each Play represents 1 playing minute in real life.
   (e.g., the game takes place over the course of 90 Plays,
   which is 90 minutes in real life)
   */
  func getTotalAthleticDecay(skillPower: Double, plays: Int) -> Double {
    
    // Get the AthleticDecay per Play (aka, minute)
    let athleticDecay = getAthleticDecay(
      from: skillPower,
      decayCoefficient: athleticDecayCoefficient)
    
    /*
     Get the total AthleticDecay based on the Plays
     a position has actively played
     */
    let athleticDecayOverTime = getAthleticDecayOverTime(plays, decay: athleticDecay)
    
    return athleticDecayOverTime
  }
  
  /*
   The greater the skillPower, the lower
   the AthleticDecayCoefficient
   */
  private func getAthleticDecay(from skillPower: Double, decayCoefficient: Double) -> Double {
    let athleticDecayPerPlay = decayCoefficient - (0.0001 * skillPower)
    return athleticDecayPerPlay
  }
  
  /*
   Total Athletic decay based on the plays (aka, minutes)
   players have played.
   */
  
  private func getAthleticDecayOverTime(_ plays: Int, decay: Double) -> Double {
    return decay * Double(plays)
  }
  
}










