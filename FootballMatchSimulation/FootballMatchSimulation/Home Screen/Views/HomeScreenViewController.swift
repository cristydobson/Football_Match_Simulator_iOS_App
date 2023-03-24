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
  
  var viewWidth: CGFloat!
  var viewHeight: CGFloat!
  
  func setupBackground() {
    view.addBlueGradientBackground()
  }
  
  func addViews() {
    
    let safeArea = view.safeAreaLayoutGuide
    viewWidth = view.frame.width
    viewHeight = view.frame.height
    
    
    /*
     Standings View
     */
    let standingsContainerView = getEmptyView()
    styleContainerView(standingsContainerView)
    view.addSubview(standingsContainerView)

    standingsView = createStandingsView()
    standingsContainerView.addSubview(standingsView)
    
    
    NSLayoutConstraint.activate([
      
      standingsView.leadingAnchor.constraint(equalTo: standingsContainerView.leadingAnchor),
      standingsView.trailingAnchor.constraint(equalTo: standingsContainerView.trailingAnchor),
      standingsView.topAnchor.constraint(equalTo: standingsContainerView.topAnchor),
      standingsView.bottomAnchor.constraint(equalTo: standingsContainerView.bottomAnchor),
      
      standingsContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 48),
      standingsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      standingsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.70),
      standingsContainerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)

    ])
    
    
    /*
     Title View
     */
//    let titleView = getEmptyView()
//    styleContainerView(titleView)
//    view.addSubview(titleView)
//
//    let titleLabel = getTitleLabel()
//    titleView.addSubview(titleLabel)
    
//    NSLayoutConstraint.activate([
//      
//      titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
//      titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
//      titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
//      titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
//      
//      titleView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 48),
//      titleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
//      titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
//      titleView.bottomAnchor.constraint(equalTo: standingsContainerView.topAnchor, constant: -12)
//    ])
    
    
    /*
     Round Card Collection View
     */
    let collectionContainerView = getEmptyView()
    view.addSubview(collectionContainerView)

    roundCollectionView = createRoundCardCollectionView()
    collectionContainerView.addSubview(roundCollectionView)

    
    NSLayoutConstraint.activate([
      collectionContainerView.leadingAnchor.constraint(
        equalTo: standingsContainerView.trailingAnchor, constant: 12),
      collectionContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      collectionContainerView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
  }
  
  
  // MARK: - View Helper Methods
  
  func getEmptyView() -> UIView {
    return ViewHelper.createEmptyView()
  }
  
  func createStandingsView() -> StandingsView {
    let standingsViewFrame = CGRect(
      origin: CGPoint.zero,
      size: CGSize(width: viewWidth*0.5, height: viewHeight*0.7))
    
    let standingsView = StandingsView(frame: standingsViewFrame)
    
    return standingsView
  }
  
  func createRoundCardCollectionView() -> RoundCardCollectionView {
    let collectionViewFrame = CGRect(
      origin: CGPoint.zero,
      size: CGSize(width: viewWidth*0.4, height: viewHeight))
    
    let collectionView = RoundCardCollectionView(
      frame: collectionViewFrame, controller: self)
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    return collectionView
  }

  func getTitleLabel() -> UILabel {
    let label = ViewHelper.createLabel(
      with: .white,
      text: "Standings",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 28, weight: .bold))
    
    return label
  }
  
  func styleContainerView(_ containerView: UIView) {
    containerView.addDropShadow(
      opacity: 0.5,
      radius: 4,
      offset: CGSize.zero,
      color: .darkBlue)
    
    containerView.addCornerRadius(10)
    containerView.addBorderStyle(borderWidth: 1, borderColor: .alphaDarkBlue)
    
    containerView.backgroundColor = .standingsColor
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





