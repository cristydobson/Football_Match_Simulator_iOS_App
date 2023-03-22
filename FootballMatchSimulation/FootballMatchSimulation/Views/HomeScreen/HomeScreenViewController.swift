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
    let collectionViewFrame = CGRect(x: 0, y: standingsContainerViewHeight+40,
                                     width: view.frame.width,
                                     height: roundCollectionViewHeight)
    roundCollectionView = RoundCardCollectionView(
      frame: collectionViewFrame, controller: self)
    roundCollectionView.backgroundColor = .red
    view.addSubview(roundCollectionView)
    
  }
  
  
  // MARK: - Bindings
  
  func setupBindings() {
    
    viewModel.$teamModels.sink { [weak self] teamModels in
      DispatchQueue.main.async {
        if teamModels.count > 0 {
          self?.loadStandings()
          self?.viewModel.generateRounds(teamModels)
        }
      }
    }.store(in: &subscriptions)
    
    viewModel.$rounds.sink { [weak self] rounds in
      DispatchQueue.main.async {
        if rounds.count > 0 {
          self?.roundCollectionView.rounds = rounds
        }
      }
    }.store(in: &subscriptions)
   
  }

  
  
  
  // MARK: - Navigation
  
//  func createSegueToGameViewController() {
//    let controller = RoundGamesViewController()
//    controller.teams = viewModel.teams
//
//    present(controller, animated: true)
//  }
  

  
  func loadStandings() {
    print("LOADING Standings with Team Models!!!!!!!\n")
  }
  
  
}





