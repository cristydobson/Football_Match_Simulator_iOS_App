//
//  RoundCardCollectionView.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/21/23.
//


import Foundation
import UIKit
import Combine


class RoundCardCollectionView: UIView {
  
  
  // MARK: - Properties
  
  private var subscriptions = Set<AnyCancellable>()
  private var controller: UIViewController!
  
  var collectionView: UICollectionView!
  let cellID = "RoundCardCell"
  
  private var viewModel = RoundCardCollectionViewModel()
     
  var rounds: [Round]! {
    didSet {
      viewModel.loadCellViewModels(from: rounds)
    }
  }
  
  
  // MARK: - Init Method
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init(frame: CGRect, controller: UIViewController) {
    self.init(frame: frame)
    self.controller = controller
    
    setupView()
    setupCollectionView()
    
    setupBindings()
    
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    backgroundColor = .clear
  }
  
  func setupCollectionView() {

    // CollectionView Layout
    let layout = CollectionViewHelper.createLayout(
      for: frame, andHeight: 0.65)
    
    // Instantiate CollectionView
    let collectionViewFrame = CGRect(
      origin: CGPoint.zero, size: frame.size)
    
    collectionView = CollectionViewHelper.createCollectionView(
      with: collectionViewFrame, andLayout: layout)
    
    // Style
    collectionView.showsVerticalScrollIndicator = false
    
    // Setup Delegates
    collectionView.dataSource = self
    collectionView.delegate = self
    
    // Register the CollectionView's cell
    collectionView.register(RoundCardCell.self, forCellWithReuseIdentifier: cellID)
    
    // Add CollectionView to current View
    addSubview(collectionView)

  }
  
  
  // MARK: - Bindings
  
  func setupBindings() {

    viewModel.$cellViewModels.sink { [weak self] _ in
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }.store(in: &subscriptions)
    
  }
  
  
  // MARK: - Navigation
  
  func pushRoundGamesViewController(for indexPath: IndexPath) {
    
    let viewController = RoundGamesViewController()
    viewController.round = rounds[indexPath.row]
    
    viewController.$updatedScores.sink { [weak self] flag in
      DispatchQueue.main.async {
        if flag {
          self?.collectionView.reloadData()
        }
      }
    }.store(in: &subscriptions)
    
    controller.navigationController?.pushViewController(viewController, animated: true)
  }
  
  
}


// MARK: - UICollectionViewDataSource

extension RoundCardCollectionView: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.cellViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellID, for: indexPath) as! RoundCardCell
    
    cell.viewModel = viewModel.getCellViewModel(at: indexPath)
    
    return cell
  }
  
}


// MARK: - UICollectionViewDelegate

extension RoundCardCollectionView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    pushRoundGamesViewController(for: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    
    if let cell = collectionView.cellForItem(at: indexPath) {
      ViewHelper.animateHighlight(for: cell)
    }
    return true
  }
  
}














