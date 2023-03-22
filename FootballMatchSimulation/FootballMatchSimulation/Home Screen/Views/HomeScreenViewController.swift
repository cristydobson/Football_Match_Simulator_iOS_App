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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupTitle()
  }
  
  
  // MARK: - Setup Methods
  
  func setupTitle() {
    for view in navigationController!.navigationBar.subviews {
      if let titleLabel = view as? UILabel {
        titleLabel.text = "Tournament"
      }
    }
  }
  
  func setupBackground() {
    view.addBlueGradientBackground()
  }
  
  func addViews() {
    
    
    let safeArea = view.safeAreaLayoutGuide
    let standingsContainerViewHeight = view.frame.height*0.3
    
    
    /*
     Title
     */
    let titleLabel = ViewHelper.createLabel(
      with: .white, text: "Tournament",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 26, weight: .semibold))
    navigationController?.navigationBar.addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(
        equalTo: (navigationController?.navigationBar.centerXAnchor)!),
      titleLabel.bottomAnchor.constraint(
        equalTo: (navigationController?.navigationBar.bottomAnchor)!)
    ])
    
    
    /*
     Header View
     */
    let headerBackgroundView = ViewHelper.createEmptyView()
    headerBackgroundView.backgroundColor = .alphaDarkBlue
    view.addSubview(headerBackgroundView)
    
    
    /*
     Standings Card
     */
    
    let standingsContainerView = ViewHelper.createEmptyView()
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
      
      headerBackgroundView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      headerBackgroundView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      headerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
      headerBackgroundView.bottomAnchor.constraint(equalTo: standingsContainerView.bottomAnchor),
      
      standingsContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      standingsContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      standingsContainerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
      standingsContainerView.setHeightContraint(by: standingsContainerViewHeight)
      
    ])
    
    
    /*
     Round Card Collection View
     */
    let collectionContainerView = ViewHelper.createEmptyView()
    view.addSubview(collectionContainerView)
    
    let navBarHeight = ViewHelper.getBarHeight(from: navigationController!)
    let roundCollectionViewHeight = view.frame.height-standingsContainerViewHeight
    
    let collectionViewFrame = CGRect(
      origin: CGPoint.zero,
      size: CGSize(width: view.frame.width, height: roundCollectionViewHeight-navBarHeight))
    
    roundCollectionView = RoundCardCollectionView(
      frame: collectionViewFrame, controller: self)
    
    roundCollectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionContainerView.addSubview(roundCollectionView)
    
    
    NSLayoutConstraint.activate([
      collectionContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      collectionContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      collectionContainerView.topAnchor.constraint(equalTo: standingsContainerView.bottomAnchor),
      collectionContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
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


  func loadStandings() {
    print("LOADING Standings with Team Models!!!!!!!\n")
  }
  
  
}





