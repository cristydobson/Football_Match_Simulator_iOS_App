//
//  RoundGamesCollectionView.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/22/23.
//



import Foundation
import UIKit
import Combine


class RoundGamesCollectionView: UIView {

  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  private var controller: UIViewController!
  
  var collectionView: UICollectionView!
  let cellID = "RoundGameCell"
  
  private var viewModel = RoundGamesCollectionViewModel()
  var round: Round!
    
  
  // MARK: - Init Method
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init(frame: CGRect, controller: UIViewController, round: Round) {
    self.init(frame: frame)
    self.controller = controller
    self.round = round
  
    setupView()
    setupCollectionView()
        
    viewModel.loadCellViewModels(from: round)
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    backgroundColor = .clear
  }
  
  func setupCollectionView() {

    // CollectionView Layout
    let layout = getCollectionViewLayout()
    
    // Instantiate CollectionView
    collectionView = CollectionViewHelper.createCollectionView(
      with: frame, andLayout: layout)
    
    // Style
    collectionView.showsVerticalScrollIndicator = false
    
    // Setup Delegates
    collectionView.dataSource = self
    collectionView.delegate = self
    
    // Register the CollectionView's cell
    collectionView.register(RoundGameCell.self, forCellWithReuseIdentifier: cellID)
    
    // Add CollectionView to current View
    addSubview(collectionView)
    
  }
  
  func getCollectionViewLayout() -> UICollectionViewFlowLayout {
    let cellWidth = frame.width*0.45
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(
      top: 0, left: 40, bottom: 0, right: 40)
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth*0.8)
    
    return layout
  }
  
  
  // MARK: - Navigation
  
  func presentGameViewController(for indexPath: IndexPath) {
    
    let viewController = GameSimulationViewController()
    viewController.modalPresentationStyle = .fullScreen
    
    let match = round.matches[indexPath.row]
    viewController.teams = createPlayingTeams(for: match)
    
    let didReplayGame = match.gameIsPlayed
    
    // Subscribe to receive the final score
    viewController.$goals.sink { [weak self] teamGoals in
      if let goals = teamGoals {
        DispatchQueue.main.async {
          self?.updateGameScores(goals, for: match,
                                 at: indexPath, onReplay: didReplayGame)
        }
      }
    }.store(in: &subscriptions)

    controller.present(viewController, animated: true)
  }
  
  func createPlayingTeams(for match: Round.Match) -> [PlayingTeam] {
    let team1 = PlayingTeam(team: match.teams[0])
    let team2 = PlayingTeam(team: match.teams[1])
    return [team1, team2]
  }
  
  func updateGameScores(_ scores: [Int], for match: Round.Match, at indexPath: IndexPath, onReplay: Bool) {
    
    viewModel.setNewGameScore(scores, at: indexPath)
    subscriptions.removeAll()
    collectionView.reloadData()
    
    if !onReplay {
      match.updateTeamStandings()
    }
    else {
      match.gameReplayed()
    }
  }
  
}


// MARK: - UICollectionViewDataSource

extension RoundGamesCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.cellViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellID, for: indexPath) as! RoundGameCell
    
    cell.viewModel = viewModel.getCellViewModel(at: indexPath)
    
    cell.$cellTapped.sink { [weak self] flag in
      if flag {
        DispatchQueue.main.async {
          self?.presentGameViewController(for: indexPath)
        }
      }
    }.store(in: &subscriptions)
    
    return cell
  }
  
}


