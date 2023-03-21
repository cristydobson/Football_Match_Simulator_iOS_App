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
  
  // Cards
  var standingsCard: StandingsCard!
  
  
  
  @IBOutlet weak var tempButton: UIButton!
  
  
  // MARK: - View Controller's Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    addViews()
    
    setupBindings()
    
    viewModel.loadTeams()
    
  }
  
  
  // MARK: - Setup Methods
  
  func addViews() {
    
    let tempView = ViewHelper.createEmptyView()
    tempView.backgroundColor = .red
    view.addSubview(tempView)
    
    let safeArea = view.safeAreaLayoutGuide
      
    standingsCard = UINib(nibName: "StandingsCard", bundle: nil)
      .instantiate(withOwner: nil)[0] as? StandingsCard
//    standingsCard.frame.origin = CGPoint.zero
//    standingsCard.frame.size.width = view.frame.width
    
    standingsCard.backgroundColor = .yellow
    tempView.addSubview(standingsCard)

    
    NSLayoutConstraint.activate([
      standingsCard.leadingAnchor.constraint(equalTo: tempView.leadingAnchor),
      standingsCard.trailingAnchor.constraint(equalTo: tempView.trailingAnchor),
      standingsCard.topAnchor.constraint(equalTo: tempView.topAnchor),
      standingsCard.bottomAnchor.constraint(equalTo: tempView.topAnchor),
      
      tempView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      tempView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      tempView.topAnchor.constraint(equalTo: safeArea.topAnchor),
      tempView.widthAnchor.constraint(equalTo: view.widthAnchor)
    ])
  
    
  }
  
  
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





