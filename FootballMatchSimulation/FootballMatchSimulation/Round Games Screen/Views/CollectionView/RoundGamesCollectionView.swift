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
    
    setupBindings()
    
    viewModel.loadCellViewModels(from: round)
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    backgroundColor = .clear
  }
  
  func setupCollectionView() {

    // CollectionView Layout
    let layout = CollectionViewHelper.createLayout(
      for: frame, andHeight: 0.8)
    
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
  
  
  func setupBindings() {
    
    viewModel.$cellViewModels.sink { [weak self] _ in
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }.store(in: &subscriptions)
    
  }
  
  
  // MARK: - Navigation
  
  func presentGameViewController(for indexPath: IndexPath) {
    
    let viewController = GameSimulationViewController()
    viewController.modalPresentationStyle = .fullScreen
    
    let match = round.matches[indexPath.row]
    let team1 = PlayingTeam(team: match.teams[0])
    let team2 = PlayingTeam(team: match.teams[1])
    
    viewController.teams = [team1, team2]
    
    controller.present(viewController, animated: true)
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
      DispatchQueue.main.async {
        if flag {
          self?.presentGameViewController(for: indexPath)
        }
      }
    }.store(in: &subscriptions)
    
    return cell
  }
  
}


