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
 
  
  // MARK: - Setup Methods
  
  func setupBackground() {
    view.addBlueGradientBackground()
  }
  
  func addViews() {
    
    let safeArea = view.safeAreaLayoutGuide
    let viewWidth = view.frame.width
    let viewHeight = view.frame.height
    
    /*
     Standings View
     */
    let standingsContainerView = ViewHelper.createEmptyView()
    styleStandingsContainer(standingsContainerView)
    view.addSubview(standingsContainerView)

    let standingsViewFrame = CGRect(
      origin: CGPoint.zero,
      size: CGSize(width: viewWidth*0.5, height: viewHeight*0.7))
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

    let collectionViewFrame = CGRect(
      origin: CGPoint.zero,
      size: CGSize(width: viewWidth*0.4, height: viewHeight))

    roundCollectionView = RoundCardCollectionView(
      frame: collectionViewFrame, controller: self)

    roundCollectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionContainerView.addSubview(roundCollectionView)

    
    NSLayoutConstraint.activate([
      collectionContainerView.leadingAnchor.constraint(
        equalTo: standingsContainerView.trailingAnchor, constant: 12),
      collectionContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      collectionContainerView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
  }
  
  func styleStandingsContainer(_ cardView: UIView) {
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
      if teams.count > 0 {
        DispatchQueue.main.async {
          self?.viewModel.loadRounds(with: teams)
          self?.viewModel.createStandingsViewModel()
        }
      }
    }.store(in: &subscriptions)

    
    viewModel.$rounds.sink { [weak self] rounds in
      if rounds.count > 0 {
        DispatchQueue.main.async {
          self?.roundCollectionView.rounds = rounds
        }
      }
    }.store(in: &subscriptions)
    
    
    viewModel.$standingsViewModel.sink { [weak self] stViewModel in
      if let standingsVm = stViewModel {
        DispatchQueue.main.async {
          self?.setStandingsViewModel(with: standingsVm)
        }
      }
    }.store(in: &subscriptions)
    
    
    viewModel.$updateStandings.sink { [weak self] flag in
      if flag {
        DispatchQueue.main.async {
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

  
}





