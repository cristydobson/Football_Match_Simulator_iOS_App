//
//  GameSimulationViewModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/20/23.
//


import Foundation
import Combine


class GameSimulationViewModel: ObservableObject {
  
  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  @Published private(set) var currentEvent: String = ""
  @Published private(set) var currentEvents: [String] = []
    
  
  // MARK: - Methods
  

  
  
}
