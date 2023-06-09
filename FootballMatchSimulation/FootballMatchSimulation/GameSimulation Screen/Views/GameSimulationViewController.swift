///
/// GameSimulationViewController.swift
///
/// Displays the GameSimulation states.
/// The Match between 2 teams.
///
/// Created by Cristina Dobson
///


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
  var goalView: GoalView!
  var startImageView: UIImageView!
  var finalResultTitleLabel: UILabel!
  
  // Buttons
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
  
  var safeArea: UILayoutGuide!
  
  func setupBackground() {
    view.addBlueGradientBackground()
  }
  
  // Add the views to display
  func addViews() {
    
    safeArea = view.safeAreaLayoutGuide
    
    setupHudView()
    
    setupTeamView()
    
    setupGameUpdatesLabel()
    
    setupDismissButton()
 
    /*
     Final Result Title Label
     */
    finalResultTitleLabel = createFinalResultTitleLabel()
    
  }
  
  
  // MARK: - Create the HUD View
  
  /*
   HUD View
   */
  func setupHudView() {
    hudView = createHudView()
    view.addSubview(hudView)
    
    NSLayoutConstraint.activate([
      hudView.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor, constant: 40),
      hudView.trailingAnchor.constraint(
        equalTo: safeArea.trailingAnchor, constant: -40),
      hudView.topAnchor.constraint(
        equalTo: safeArea.topAnchor, constant: 4),
      hudView.setHeightContraint(by: 50)
    ])
  }
  
  func createHudView() -> HudView {
    let newView = HudView()
    newView.translatesAutoresizingMaskIntoConstraints = false
    newView.viewModel = viewModel.loadHudViewModel(for: teams)
    
    return newView
  }
  
  
  // MARK: - Create TeamView
  
  /*
   TeamsContainerView
   */
  func setupTeamView() {
    teamView = createTeamView()
    view.addSubview(teamView)
    
    NSLayoutConstraint.activate([
      teamView.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor, constant: 50),
      teamView.trailingAnchor.constraint(
        equalTo: safeArea.trailingAnchor, constant: -50),
      teamView.topAnchor.constraint(
        equalTo: hudView.bottomAnchor, constant: 24),
      teamView.heightAnchor.constraint(
        equalTo: view.heightAnchor, multiplier: 0.4)
    ])
  }
  
  func createTeamView() -> TeamView {
    let newView = TeamView()
    newView.translatesAutoresizingMaskIntoConstraints = false
    newView.viewModel = viewModel.loadTeamViewModel(for: teams)
    
    return newView
  }
  
  
  // MARK: - Game Events Label
  
  /*
   Updates Label
   */
  func setupGameUpdatesLabel() {
    updatesLabel = createEventUpdatesLabel()
    view.addSubview(updatesLabel)
    
    NSLayoutConstraint.activate([
      updatesLabel.leadingAnchor.constraint(
        greaterThanOrEqualTo: safeArea.leadingAnchor, constant: 24),
      updatesLabel.trailingAnchor.constraint(
        greaterThanOrEqualTo: safeArea.trailingAnchor, constant: -24),
      updatesLabel.topAnchor.constraint(
        equalTo: teamView.bottomAnchor, constant: 24),
      updatesLabel.centerXAnchor.constraint(
        equalTo: view.centerXAnchor)
    ])
  }
  
  func createEventUpdatesLabel() -> UILabel {
    let label = ViewHelper.createLabel(
      with: .white,
      text: "",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 28, weight: .black))
    
    return label
  }
  
  
  // MARK: - Dismiss button
  
  /*
   Button to go back to RoundGamesViewController
   after the game has finished playing
   */
  func setupDismissButton() {
    dismissControllerButton = createDismissButton()
    
    NSLayoutConstraint.activate([
      dismissControllerButton.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor, constant: 48),
      dismissControllerButton.topAnchor.constraint(
        equalTo: view.topAnchor, constant: 24),
      dismissControllerButton.setWidthContraint(by: 60),
      dismissControllerButton.heightAnchor.constraint(
        equalTo: dismissControllerButton.widthAnchor, multiplier: 1)
    ])
  }
  
  func createDismissButton() -> UIButton {
    let button = UIButton()
    
    button.setImage(
      UIImage(named: "Close_button_default"),
      for: .normal)
    
    button.setImage(
      UIImage(named: "Close_button_tapped"),
      for: .selected)
    
    button.addTarget(
      self,
      action: #selector(dismissControllerAction),
      for: .touchUpInside)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.isHidden = true
    
    view.addSubview(button)
    
    return button
  }
  
  
  // MARK: - Result Title Label
  
  func createFinalResultTitleLabel() -> UILabel {
    let label = ViewHelper.createLabel(
      with: .white,
      text: "Final Result",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 38, weight: .bold))
    
    label.isHidden = true
    
    view.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    return label
  }
  
  
  // MARK: - Start Game Simulation
  
  func setupGameSimulation() {
    gameSimulation = GameSimulation(
      homeTeam: teams[0], visitorTeam: teams[1])
    
    setupBindings()
    
    gameSimulation.startFirstHalfSimulation()
    
  }
  
  
  // MARK: - Goal View
  
  /*
   Animate in when the game is in
   .goalScored state
   */
  func setGoalView() {
   
    if goalView == nil {
      
      let frame = CGRect(
        origin: CGPoint(x: 0, y: 200),
        size: CGSize(width: view.frame.width, height: 100))
      
      goalView = GoalView(frame: frame)
      goalView.center.x = view.center.x
    }
    
    animateViewIn(goalView, waitTime: 1.5)
  }
  
  
  // MARK: - Game About to Start View
  
  /*
   Animate in when the game is in
   .aboutToStart state
   */
  func setGameAboutToStartView(waitTime: TimeInterval) {
    
    if startImageView == nil {
      
      startImageView = UIImageView(
        image: UIImage(named: "Start-ball"))
      
      startImageView.center = view.center
    }
    
    animateViewIn(startImageView, waitTime: waitTime)
  }
  
  
  // MARK: - Half-Time View
  
  /*
   Animate in when the game is in
   .halfTime state
   */
  func setHalfTimeView() {
    
    var halfTimeView: HalfTimeView!
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      halfTimeView = HalfTimeView(frame: self.view.frame)
      self.view.addSubview(halfTimeView)
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      halfTimeView.removeFromSuperview()
    }
  }
  
  
  // MARK: - Set Game Finished View
  
  /*
   Prepare the view for when the game
   enters the .finished state
   */
  func setGameFinishedView() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.hudView.isHidden = true
      self.updatesLabel.isHidden = true
      
      self.finalResultTitleLabel.isHidden = false
      self.dismissControllerButton.isHidden = false
    }
  }
  
  
  
  // MARK: - Animate Views In/Out
  
  // Animate any view in
  func animateViewIn(_ aView: UIView, waitTime: TimeInterval) {
    
    view.addSubview(aView)
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
      aView.alpha = 1
    })
    { _ in
      DispatchQueue.main.asyncAfter(deadline: .now() + waitTime) {
        self.animateViewOut(aView)
      }
    }
  }
  
  // Animate any view out
  func animateViewOut(_ aView: UIView) {
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
      aView.alpha = 0
    })
    { _ in
      aView.removeFromSuperview()
    }
  }

  
  // MARK: - Bindings
  
  func setupBindings() {
    
    // Update the labels in the UI
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
     
    // Listen for the game state to change
    gameSimulation.$gameState.sink { [weak self] state in
      DispatchQueue.main.async {
        
        switch state {
            
          case .goalScored:
            self?.setGoalView()
            
          case .inProgress:
            print("\n GAME IN PROGRESS!!!!!!\n")
            
          case .halfTime:
            self?.setHalfTimeView()
            
          case .finished:
            self?.setGameFinishedView()
            self?.goals = [(self?.teams[0].goals)!, (self?.teams[1].goals)!]
            
          default:
            self?.setGameAboutToStartView(waitTime: 1.5)
        }
        
      }
    }.store(in: &subscriptions)
    
  }
  
  
  // MARK: - Button Actions
  
  // Action for the dismiss button
  @objc func dismissControllerAction() {
    dismiss(animated: true)
  }
  
}








