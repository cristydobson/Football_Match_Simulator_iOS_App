///
/// HalfTimeView.swift
///
/// Displays a view during the
/// Half-Time state of the game.
///
/// Created by Cristina Dobson
///


import Foundation
import UIKit


class HalfTimeView: UIView {
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupBackgorund()
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: Setup Methods
  func setupBackgorund() {
    addBlueGradientBackground()
  }
  
  func addViews() {
    
    // Create a Half-Time image to display
    let imageView = getImageView(for: "Half_Time_image")
    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
    
  }
  
  
  // MARK: - View Helper Methods
  
  func getImageView(for image: String) -> UIImageView {
    let imageView = ViewHelper.createImageView(
      contentMode: .scaleAspectFill)
    
    imageView.image = UIImage(named: image)
    return imageView
  }

}
