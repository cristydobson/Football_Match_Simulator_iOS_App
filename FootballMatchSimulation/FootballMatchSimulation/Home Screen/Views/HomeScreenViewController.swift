///
/// HomeScreenViewController.swift
///
/// The Root ViewController.
///
/// The HomeScreen displays:
/// - The Standings View
/// - The CollectionView for the Rounds
///
/// Created by Cristina Dobson
///


import UIKit
import Combine


class HomeScreenViewController: UIViewController {
  
  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  private let viewModel = HomeScreenViewModel()
  
  // Cards
  var standingsView: StandingsView!
  var roundCollectionView: RoundCardCollectionView!
  var loadingView: LoadScreen!
  
  
  // MARK: - View Controller's Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
    setupBindings()
    viewModel.loadTeams()
  }
 
  
  // MARK: - Setup Methods
  
  var viewWidth: CGFloat!
  var viewHeight: CGFloat!
  var safeArea: UILayoutGuide!
  
  
  func setupView() {
    setupBackground()
    addViews()
    setupLoadingView()
  }
  
  func setupBackground() {
    view.addBlueGradientBackground()
  }
  
  // Add views to display
  func addViews() {
    
    safeArea = view.safeAreaLayoutGuide
    viewWidth = view.frame.width
    viewHeight = view.frame.height
    
    
    /*
     Standings View
     */
    let standingsContainerView = getEmptyView()
    setupStandingsView(in: standingsContainerView)

    
    /*
     Standings Title View
     */
    let titleContainerView = getEmptyView()
    setupStandingsTitleView(
      in: titleContainerView,
      by: standingsContainerView)
    
    
    /*
     Rounds Collection View
     */
    // Container View
    let collectionContainerView = getEmptyView()
    setupRoundCollectionView(
      in: collectionContainerView,
      by: standingsContainerView)
    
  }
  
  
  // MARK: - Standings View
  
  // Display the Standings View
  func setupStandingsView(in container: UIView) {
    // Standings View Card
    styleContainerView(container)
    view.addSubview(container)
    
    standingsView = createStandingsView()
    standingsView.translatesAutoresizingMaskIntoConstraints = false
    
    container.addSubview(standingsView)
    
    
    NSLayoutConstraint.activate([
      
      // Standings View Card
      standingsView.leadingAnchor.constraint(
        equalTo: container.leadingAnchor),
      standingsView.trailingAnchor.constraint(
        equalTo: container.trailingAnchor),
      
      
      // Container View
      container.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor, constant: 48),
      container.bottomAnchor.constraint(
        equalTo: safeArea.bottomAnchor),
      container.heightAnchor.constraint(
        equalTo: view.heightAnchor, multiplier: 0.70),
      container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
      
    ])
  }
  
  func createStandingsView() -> StandingsView {
    let standingsViewFrame = CGRect(
      origin: CGPoint.zero,
      size: CGSize(width: viewWidth*0.5, height: viewHeight*0.7))
    
    let standingsView = StandingsView(frame: standingsViewFrame)
    return standingsView
  }
  
  
  // MARK: - Standings Title View
  
  // Display the Standings Title View
  func setupStandingsTitleView(in container: UIView, by neighborView: UIView) {
    styleContainerView(container)
    view.addSubview(container)
    
    // Title Label - "Standings"
    let titleLabel = getTitleLabel()
    container.addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      
      // Title Label
      titleLabel.leadingAnchor.constraint(
        equalTo: container.leadingAnchor),
      titleLabel.trailingAnchor.constraint(
        equalTo: container.trailingAnchor),
      titleLabel.topAnchor.constraint(
        equalTo: container.topAnchor),
      titleLabel.bottomAnchor.constraint(
        equalTo: container.bottomAnchor),
      
      // Container View
      container.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor, constant: 48),
      container.bottomAnchor.constraint(
        equalTo: neighborView.topAnchor, constant: -12),
      container.widthAnchor.constraint(
        equalTo: neighborView.widthAnchor, multiplier: 1),
      container.topAnchor.constraint(
        equalTo: view.topAnchor, constant: 24)
      
    ])
  }
  
  func getTitleLabel() -> UILabel {
    let label = ViewHelper.createLabel(
      with: .white,
      text: "Standings",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 28, weight: .bold))
    return label
  }
  
  
  // MARK: - Rounds Collection View
  
  // Display the Rounds Collection View
  func setupRoundCollectionView(in container: UIView, by neighborView: UIView) {
    view.addSubview(container)
    
    // Collection View
    roundCollectionView = createRoundCardCollectionView()
    container.addSubview(roundCollectionView)
    
    NSLayoutConstraint.activate([
      // Container View
      container.leadingAnchor.constraint(
        equalTo: neighborView.trailingAnchor, constant: 12),
      container.trailingAnchor.constraint(
        equalTo: safeArea.trailingAnchor),
      container.topAnchor.constraint(
        equalTo: view.topAnchor),
      container.bottomAnchor.constraint(
        equalTo: view.bottomAnchor)
    ])
  }
  
  func createRoundCardCollectionView() -> RoundCardCollectionView {
    let collectionViewFrame = CGRect(
      origin: CGPoint.zero,
      size: CGSize(width: viewWidth*0.4, height: viewHeight))
    
    let collectionView = RoundCardCollectionView(
      frame: collectionViewFrame, controller: self)
    return collectionView
  }
  
  
  // MARK: - Loading View
  
  /*
   Display a Loading View while
   the app fully loads
   */
  func setupLoadingView() {
    
    loadingView = getLoadingView()
    view.addSubview(loadingView)
    
    NSLayoutConstraint.activate([
      loadingView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor),
      loadingView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor),
      loadingView.topAnchor.constraint(
        equalTo: view.topAnchor),
      loadingView.bottomAnchor.constraint(
        equalTo: view.bottomAnchor)
    ])
    
    // Remove it after a given waiting time
    Timer.scheduledTimer(
      timeInterval: 4,
      target: self,
      selector: #selector(dismissLoadingView),
      userInfo: nil,
      repeats: false)
    
  }
  
  // Create the Loading View
  func getLoadingView() -> LoadScreen {
    let loadScreen = UINib(nibName: "LoadScreen", bundle: nil)
      .instantiate(withOwner: nil)[0] as! LoadScreen
    
    loadScreen.translatesAutoresizingMaskIntoConstraints = false
    return loadScreen
  }
  
  // Action to remove the Loading View
  @objc func dismissLoadingView() {
    loadingView.stopAnimation()
    loadingView.removeFromSuperview()
    loadingView = nil
  }
  
  
  // MARK: - View Helper Methods
  
  // Create an empty view
  func getEmptyView() -> UIView {
    return ViewHelper.createEmptyView()
  }
  
  // Style a container view
  func styleContainerView(_ containerView: UIView) {
    containerView.addDropShadow(
      opacity: 0.5,
      radius: 8,
      offset: CGSize.zero,
      color: .darkBlue)
    
    containerView.addCornerRadius(10)
    containerView.addBorderStyle(borderWidth: 1, borderColor: .darkBlue)
    
    containerView.backgroundColor = .alphaDarkBlue
  }
  
  
  // MARK: - Setup Bindings
  
  func setupBindings() {
    
    /*
     Team models are ready
     */
    viewModel.$teams.sink { [weak self] teams in
      if teams.count > 0 {
        DispatchQueue.main.async {
          self?.viewModel.loadRounds(with: teams)
          self?.viewModel.createStandingsViewModel()
        }
      }
    }.store(in: &subscriptions)

    /*
     Round models are ready
     */
    viewModel.$rounds.sink { [weak self] rounds in
      if rounds.count > 0 {
        DispatchQueue.main.async {
          self?.roundCollectionView.rounds = rounds
        }
      }
    }.store(in: &subscriptions)
    
    
    /*
     StandingsViewModel is ready
     */
    viewModel.$standingsViewModel.sink { [weak self] stViewModel in
      if let standingsVm = stViewModel {
        DispatchQueue.main.async {
          self?.setStandingsViewModel(with: standingsVm)
        }
      }
    }.store(in: &subscriptions)
    
    
    /*
     Update the Team standings and reload the Round
     collectionView after a match has been played
     */
    viewModel.$updateStandings.sink { [weak self] flag in
      if flag {
        DispatchQueue.main.async {
          self?.standingsView.updateStandings()
          self?.roundCollectionView.reloadCollectionView()
        }
      }
    }.store(in: &subscriptions)

  }
  
  // Pass the StandingsViewModel to its owner
  func setStandingsViewModel(with viewModel: StandingsViewModel) {
    standingsView.viewModel = viewModel
  }
  
 
}





