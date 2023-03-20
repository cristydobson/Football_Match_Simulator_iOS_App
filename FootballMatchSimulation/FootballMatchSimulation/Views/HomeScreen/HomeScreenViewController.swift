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
  
  
  @IBOutlet weak var tempButton: UIButton!
  
  
  // MARK: - View Controller's Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBindings()
    
    viewModel.loadTeams()
    
  }
  
  
  // MARK: - Setup Methods
  
  
  
  
  
  // MARK: - Bindings
  
  func setupBindings() {
    
    //    viewModel.$teams.sink { [weak self] _ in
    //      DispatchQueue.main.async {
    //        print("DECODED TEAMS!!!!!!")
    //      }
    //    }
    
  }
  
  
  
  // MARK: - Button Actions
  
  @IBAction func tempButtonAction(_ sender: UIButton) {
    createSegueToGameViewController()
  }
  
  
  
  // MARK: - Navigation
  
  func createSegueToGameViewController() {
    let controller = GameSimulationViewController()
    controller.modalPresentationStyle = .fullScreen
    
    let team1 = PlayingTeam(team: viewModel.teams.first!)
    let team2 = PlayingTeam(team: viewModel.teams.last!)
    controller.teams = [team1, team2]
    
    present(controller, animated: true)
  }
  
  
  
}





