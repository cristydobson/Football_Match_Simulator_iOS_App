//
//  ViewHelper.swift
//  FootballMatchSimulation
//
//  Created by Cristina Dobson on 3/19/23.
//


import Foundation
import UIKit


extension UIView {
  
  // Constraining Methods
  func setHeightContraint(by constant: CGFloat) -> NSLayoutConstraint {
    return heightAnchor.constraint(equalToConstant: constant)
  }
  
  // Add a gradient color to the background view
  func addGradientBackground() {
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = [
      UIColor.darkerBlue.cgColor,
      UIColor.mediumBlue.cgColor,
      UIColor.lightBlue.cgColor
    ]
    gradient.locations = [0.30, 0.70, 1]
    layer.addSublayer(gradient)
  }
  
}


struct ViewHelper {
  
  // Create an empty UIView
  static func createEmptyView() -> UIView {
    let newView = UIView()
    newView.translatesAutoresizingMaskIntoConstraints = false
    return newView
  }
  
  // Create a Label
  static func createLabel(with color: UIColor, text: String, alignment: NSTextAlignment, font: UIFont) -> UILabel {
    
    let newLabel = UILabel()
    newLabel.textColor = color
    newLabel.text = text
    newLabel.textAlignment = alignment
    newLabel.font = font
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    newLabel.adjustsFontSizeToFitWidth = true
    return newLabel
  }
  
  // Create a Stack View
  static func createStackView(_ axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = axis
    stackView.distribution = distribution
    stackView.alignment = .center
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }
  
  // Create an ImageView
  static func createImageView(contentMode: UIView.ContentMode) -> UIImageView {
    let newImageView = UIImageView()
    newImageView.contentMode = contentMode
    newImageView.backgroundColor = .clear
    newImageView.translatesAutoresizingMaskIntoConstraints = false
    return newImageView
  }
  
}
