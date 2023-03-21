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
  var roundCollectionView: RoundCardCollectionView!
  
  
  @IBOutlet weak var tempButton: UIButton!
  
  
  // MARK: - View Controller's Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBackground()
    addViews()
    
    setupBindings()
    
    viewModel.loadTeams()
    
  }
  
  
  // MARK: - Setup Methods
  
  func setupBackground() {
    view.addGradientBackground()
  }
  
  func addViews() {
    
    let safeArea = view.safeAreaLayoutGuide
    let standingsContainerViewHeight = view.frame.height*0.3
    
    let standingsContainerView = ViewHelper.createEmptyView()
    standingsContainerView.backgroundColor = UIColor.darkGray
    view.addSubview(standingsContainerView)
      
    standingsCard = UINib(nibName: "StandingsCard", bundle: nil)
      .instantiate(withOwner: nil)[0] as? StandingsCard
    standingsCard.translatesAutoresizingMaskIntoConstraints = false
    standingsContainerView.addSubview(standingsCard)

    
    NSLayoutConstraint.activate([
      standingsCard.leadingAnchor.constraint(equalTo: standingsContainerView.leadingAnchor),
      standingsCard.trailingAnchor.constraint(equalTo: standingsContainerView.trailingAnchor),
      standingsCard.topAnchor.constraint(equalTo: standingsContainerView.topAnchor),
      standingsCard.bottomAnchor.constraint(equalTo: standingsContainerView.topAnchor),
      
      standingsContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      standingsContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      standingsContainerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
      standingsContainerView.setHeightContraint(by: standingsContainerViewHeight)
    ])

    
    /*
     Round Card Collection View
     */
    let roundCollectionViewHeight = view.frame.height-standingsContainerViewHeight
    roundCollectionView = RoundCardCollectionView(
      frame: CGRect(x: 0, y: standingsContainerViewHeight+40,
                    width: view.frame.width,
                    height: roundCollectionViewHeight))
    roundCollectionView.backgroundColor = .red
    view.addSubview(roundCollectionView)
    
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





