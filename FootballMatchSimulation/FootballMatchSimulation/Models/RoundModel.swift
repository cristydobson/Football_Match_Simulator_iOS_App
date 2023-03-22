//
//  RoundModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//


import Foundation


struct Round {
  let name: String
  let matches: [Match]
  
  struct Match {
    let teams: [TeamModel]
  }
}
