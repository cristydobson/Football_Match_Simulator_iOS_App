//
//  TeamModel.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/17/23.
//


import Foundation


class Team: Codable {
  
  let name: String
  let stadium: String
  let image_name: String
  let keeper: Player
  let defenders: [Player]
  let midfielders: [Player]
  let attackers: [Player]
  
}

class Player: Codable {
  
  let name: String
  let shirt: Int
  let position: String
  let skillPower: Double
  
}




