//
//  GameSimulationViewController.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation
import UIKit
import Combine


class GameSimulationViewController: UIViewController {
  
  
  // MARK: - Properties
  
  private var viewModel = GameSimulationViewModel()
  private var subscriptions = Set<AnyCancellable>()
  
  // Game Simulation
  private var gameSimulation: GameSimulation!
  var teams: [PlayingTeam] = []
  
  // Views
  var hudView: HudView!
  var teamView: TeamView!
  var updatesLabel: UILabel!
  
  
  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    transitionToLandscape()
    
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    setupBackground()
    addViews()
    gameSimulation = GameSimulation(homeTeam: teams[0], visitorTeam: teams[1])
    setupBindings()
    gameSimulation.startFirstTimeSimulation()
  }
  
  
  // MARK: - Swetup Methods
  
  func transitionToLandscape() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.appOrientation = .landscape
  }
  
  func setupBackground() {
    view.addGradientBackground()
  }
  
  func addViews() {
    
    let safeArea = view.safeAreaLayoutGuide
    
    /*
     HUD View
     */
    hudView = HudView()
    hudView.translatesAutoresizingMaskIntoConstraints = false
    hudView.viewModel = viewModel.loadHudViewModel(for: teams)
    view.addSubview(hudView)
    
    NSLayoutConstraint.activate([
      hudView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
      hudView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40),
      hudView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
      hudView.setHeightContraint(by: 50)
    ])
    
    
    /*
     TeamsContainerView
     */
    teamView = TeamView()
    teamView.translatesAutoresizingMaskIntoConstraints = false
    teamView.viewModel = viewModel.loadTeamViewModel(for: teams)
    view.addSubview(teamView)
    
    NSLayoutConstraint.activate([
      teamView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 100),
      teamView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -100),
      teamView.topAnchor.constraint(equalTo: hudView.bottomAnchor, constant: 24),
      teamView.setHeightContraint(by: 200)
    ])
    
    
    /*
     Updates Label
     */
    
    updatesLabel = ViewHelper.createLabel(
      with: .black, text: "", //Blowing the whistle...
      alignment: .center, font: UIFont.systemFont(ofSize: 24, weight: .medium))
    view.addSubview(updatesLabel)
    
    NSLayoutConstraint.activate([
      updatesLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeArea.leadingAnchor, constant: 24),
      updatesLabel.trailingAnchor.constraint(greaterThanOrEqualTo: safeArea.trailingAnchor, constant: -24),
      updatesLabel.topAnchor.constraint(equalTo: teamView.bottomAnchor, constant: 24),
      updatesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
  }
  
  
  // MARK: - Bindings
  
  func setupBindings() {
    
    subscriptions = [
      gameSimulation.$currentEvent
        .receive(on: DispatchQueue.main)
        .assign(to: \.text!, on: updatesLabel),
      gameSimulation.$plays.map { String($0) }
        .receive(on: DispatchQueue.main)
        .assign(to: \.text!, on: hudView.playsCounter),
      gameSimulation.$team1Goals.map { String($0) }
        .receive(on: DispatchQueue.main)
        .assign(to: \.text!, on: teamView.team1ScoreLabel),
      gameSimulation.$team2Goals.map { String($0) }
        .receive(on: DispatchQueue.main)
        .assign(to: \.text!, on: teamView.team2ScoreLabel)
    ]
     
    gameSimulation.$gameState.sink { [weak self] state in
      DispatchQueue.main.async {
        
        switch state {
          case .inProgress:
            print("\n GAME IN PROGRESS!!!!!!\n")
          case .halfTime:
            print("\n GAME AT HALFTIME!!!!!!!\n")
          case .finished:
            print("\n GAME IS FINISHED!!!!!!\n")
          default:
            print("\n GAME ABOUT TO START!!!!!\n")
        }
        
      }
    }.store(in: &subscriptions)
    
  }
  
  
}








