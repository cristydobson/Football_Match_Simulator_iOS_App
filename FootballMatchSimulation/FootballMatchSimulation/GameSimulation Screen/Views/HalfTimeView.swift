//
//  HalfTimeView.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/25/23.
//


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
