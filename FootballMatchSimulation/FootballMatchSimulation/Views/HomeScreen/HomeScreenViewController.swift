//
//  HomeScreenViewController.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/17/23.
//


import UIKit
import Combine


class HomeScreenViewController: UIViewController {
  
  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  private let viewModel = HomeScreenViewModel()
  
  
  // MARK: - View Controller's Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBindings()
    
    viewModel.loadTeams()
    
    startSimulation()
  }
  
  
  
  
  
  // MARK: - Bindings
  
  func setupBindings() {
    
//    viewModel.$teams.sink { [weak self] _ in
//      DispatchQueue.main.async {
//        print("DECODED TEAMS!!!!!!")
//      }
//    }
    
  }
  
  
  
  
  // TODO: - DELETE Testing Code ******
  

  func startSimulation() {
    
    let team1 = PlayingTeam(team: viewModel.teams.first!)
    let team2 = PlayingTeam(team: viewModel.teams.last!)
    
    
    let gameSimulation = GameSimulation(team1: team1, team2: team2)
    
    
  }
  
  
  
}





