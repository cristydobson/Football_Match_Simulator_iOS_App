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
  var standingsView: StandingsView!
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
        
  }
 
  
  // MARK: - Setup Methods
  
  func setupBackground() {
    view.addBlueGradientBackground()
  }
  
  func addViews() {
    
    
    let safeArea = view.safeAreaLayoutGuide
    let viewFrame = view.frame
    
    /*
     Standings View
     */
    let standingsContainerView = ViewHelper.createEmptyView()
    setupStandingsCard(for: standingsContainerView)
    view.addSubview(standingsContainerView)

    let standingsViewFrame = CGRect(
      origin: CGPoint.zero,
      size: CGSize(width: viewFrame.width*0.5,
                   height: viewFrame.height*0.7))
    standingsView = StandingsView(frame: standingsViewFrame)
    standingsContainerView.addSubview(standingsView)
    
    NSLayoutConstraint.activate([
      
      standingsView.leadingAnchor.constraint(equalTo: standingsContainerView.leadingAnchor),
      standingsView.trailingAnchor.constraint(equalTo: standingsContainerView.trailingAnchor),
      standingsView.topAnchor.constraint(equalTo: standingsContainerView.topAnchor),
      standingsView.bottomAnchor.constraint(equalTo: standingsContainerView.bottomAnchor),
      
      standingsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
      standingsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      standingsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
      standingsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)

    ])
    
    
    /*
     Round Card Collection View
     */
    let collectionContainerView = ViewHelper.createEmptyView()
    view.addSubview(collectionContainerView)

    let roundCollectionViewHeight = view.frame.height

    let collectionViewFrame = CGRect(
      origin: CGPoint.zero,
      size: CGSize(width: view.frame.width*0.4, height: roundCollectionViewHeight))

    roundCollectionView = RoundCardCollectionView(
      frame: collectionViewFrame, controller: self)

    roundCollectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionContainerView.addSubview(roundCollectionView)

    
    NSLayoutConstraint.activate([
      collectionContainerView.leadingAnchor.constraint(equalTo: standingsContainerView.trailingAnchor, constant: 12),
      collectionContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      collectionContainerView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
  }
  
  func setupStandingsCard(for cardView: UIView) {
    cardView.addDropShadow(
      opacity: 0.5,
      radius: 4,
      offset: CGSize.zero,
      color: .darkBlue)
    cardView.addCornerRadius(15)
    cardView.addBorderStyle(borderWidth: 1, borderColor: .alphaDarkBlue)
    cardView.backgroundColor = .standingsColor
  }
  
  
  // MARK: - Bindings
  
  func setupBindings() {
    
    viewModel.$teams.sink { [weak self] teams in
      
      DispatchQueue.main.async {
        if teams.count > 0 {
          self?.viewModel.loadRounds(with: teams)
          self?.viewModel.createStandingsViewModel()
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
    
    
    viewModel.$standingsViewModel.sink { [weak self] stViewModel in
      DispatchQueue.main.async {
        if let standingsVm = stViewModel {
          self?.setStandingsViewModel(with: standingsVm)
        }
      }
    }.store(in: &subscriptions)
    
    
    viewModel.$updateStandings.sink { [weak self] flag in
      DispatchQueue.main.async {
        print("UPDATE SATANDINGS Hvc outer: \(flag)!!!!!!!!!")
        if flag {
          print("UPDATE SATANDINGS Hvc inner: \(flag)!!!!!!!!!")
          self?.standingsView.updateStandings()
          self?.roundCollectionView.reloadCollectionView()
        }
      }
    }.store(in: &subscriptions)

  }
  
  
  // MARK: - Setup Standings
  
  func setStandingsViewModel(with viewModel: StandingsViewModel) {
    standingsView.viewModel = viewModel
  }
  
//  func setupStandings(from rounds: [Round]) {
//
//    let teams = viewModel.setupTeamStandings(from: rounds)
//
//    standingsCard.viewModel = StandingsCardViewModel(teams: teams)
//  }
  
//  func setupStandings(from teams: [Team]) {
//    let sortedTeams = viewModel.sortTeamsByStandings(teams)
//    standingsCard.viewModel = StandingsCardViewModel(teams: sortedTeams)
//  }

  
}





