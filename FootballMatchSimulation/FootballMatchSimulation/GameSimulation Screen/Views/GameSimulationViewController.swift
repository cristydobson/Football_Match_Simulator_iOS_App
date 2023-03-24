//
//  GameSimulationViewController.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation
import UIKit
import Combine


class GameSimulationViewController: UIViewController, ObservableObject {
  
  
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
  var dismissControllerButton: UIButton!
  
  // Game Finished
  @Published var goals: [Int]!
  
  
  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBackground()
    addViews()
    
    setupGameSimulation()
  }
  
  
  // MARK: - Setup Methods
  
  func setupBackground() {
    view.addBlueGradientBackground()
  }
  
  func addViews() {
    
    let safeArea = view.safeAreaLayoutGuide
    
    /*
     HUD View
     */
    hudView = createHudView()
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
    teamView = createTeamView()
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
    updatesLabel = createUpdatesLabel()
    view.addSubview(updatesLabel)
    
    NSLayoutConstraint.activate([
      updatesLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeArea.leadingAnchor, constant: 24),
      updatesLabel.trailingAnchor.constraint(greaterThanOrEqualTo: safeArea.trailingAnchor, constant: -24),
      updatesLabel.topAnchor.constraint(equalTo: teamView.bottomAnchor, constant: 24),
      updatesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    
    /*
     Dismiss ViewController button
     */
    dismissControllerButton = createDismissButton()
    
    NSLayoutConstraint.activate([
      dismissControllerButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
      dismissControllerButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
      dismissControllerButton.setWidthContraint(by: 60),
      dismissControllerButton.heightAnchor.constraint(equalTo: dismissControllerButton.widthAnchor, multiplier: 1)
    ])
    
  }
  
  func createHudView() -> HudView {
    let newView = HudView()
    newView.translatesAutoresizingMaskIntoConstraints = false
    newView.viewModel = viewModel.loadHudViewModel(for: teams)
    
    return newView
  }
  
  func createTeamView() -> TeamView {
    let newView = TeamView()
    newView.translatesAutoresizingMaskIntoConstraints = false
    newView.viewModel = viewModel.loadTeamViewModel(for: teams)
    
    return newView
  }
  
  func createUpdatesLabel() -> UILabel {
    let label = ViewHelper.createLabel(
      with: .black,
      text: "",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 24, weight: .medium))
    
    return label
  }
  
  func createDismissButton() -> UIButton {
    let button = UIButton()
    button.setTitle("X", for: .normal)
    
    button.addTarget(
      self,
      action: #selector(dismissControllerAction),
      for: .touchUpInside)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.isHidden = true
    
    view.addSubview(button)
    
    return button
  }
  
  
  // MARK: - Bindings
  
  func setupGameSimulation() {
    gameSimulation = GameSimulation(
      homeTeam: teams[0], visitorTeam: teams[1])
    
    setupBindings()
    gameSimulation.startFirstTimeSimulation()
  }
  
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
            self?.dismissControllerButton.isHidden = false
            self?.goals = [(self?.teams[0].goals)!, (self?.teams[1].goals)!]
          default:
            print("\n GAME ABOUT TO START!!!!!\n")
        }
        
      }
    }.store(in: &subscriptions)
    
  }
  
  
  // MARK: - Button Actions
  
  @objc func dismissControllerAction() {
    dismiss(animated: true)
  }
  
}








