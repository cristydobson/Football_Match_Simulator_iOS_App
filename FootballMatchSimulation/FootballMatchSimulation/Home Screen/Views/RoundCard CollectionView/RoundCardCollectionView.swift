///
/// RoundCardCollectionView.swift
///
/// The collectionView displaying the Rounds.
///
/// Created by Cristina Dobson
///


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
  
  // Rounds
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
  
  // Add the collectionView that displays the Rounds.
  func setupCollectionView() {

    // CollectionView Layout
    let layout = getCollectionViewLayout()
    
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
  
  /*
   Create the UICollectionViewFlowLayout
   for the collectionView
   */
  func getCollectionViewLayout() -> UICollectionViewFlowLayout {
    let cellWidth = frame.width
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.minimumLineSpacing = 12
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth*0.65)
    
    return layout
  }   
  
  
  // MARK: - Bindings
  
  func setupBindings() {

    /*
     Receive the cellViewModels
     for the CollectionView
     */
    viewModel.$cellViewModels.sink { [weak self] viewModels in
      if viewModels.count > 0 {
        DispatchQueue.main.async {
          self?.collectionView.reloadData()
        }
      }
    }.store(in: &subscriptions)
    
  }
  
  
  // MARK: - Navigation
  
  /*
   Present the viewController containing
   the matches in the user-selected Round
   */
  func presentRoundGamesViewController(for indexPath: IndexPath) {
    let viewController = RoundGamesViewController()
    
    let round = rounds[indexPath.row]
    viewController.round = round
    
    if UIDevice.current.userInterfaceIdiom == .pad {
      viewController.modalPresentationStyle = .fullScreen
    }
    
    controller.present(viewController, animated: true)
  }
  
  
  // MARK: - Helper Methods
  
  func reloadCollectionView() {
    collectionView.reloadData()
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
    presentRoundGamesViewController(for: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    
    if let cell = collectionView.cellForItem(at: indexPath) {
      ViewHelper.animateHighlight(for: cell)
    }
    return true
  }
  
}















