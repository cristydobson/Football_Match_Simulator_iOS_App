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
  
  func setWidthContraint(by constant: CGFloat) -> NSLayoutConstraint {
    return widthAnchor.constraint(equalToConstant: constant)
  }
  
  
  // MARK: - Add Gradient to Background
  
  func addBlueGradientBackground() {
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = [
      UIColor.darkerBlue.cgColor,
      UIColor.mediumBlue.cgColor,
      UIColor.lightBlue.cgColor
    ]
    gradient.locations = [0.25, 0.50, 0.75, 1]
    layer.addSublayer(gradient)
  }
  
//  func addGreenGradientBackground() {
//    let gradient = CAGradientLayer()
//    gradient.frame = bounds
//    gradient.colors = [
//      UIColor.darkGreen.cgColor,
//      UIColor.mediumGreen.cgColor,
//      UIColor.darkGreen.cgColor,
//      UIColor.lightGreen.cgColor
//    ]
//    gradient.locations = [0.25, 0.50, 0.75, 1]
//    layer.addSublayer(gradient)
//  }
  
  
  // MARK: - Add Corner Radius
  
  //Add corner radius to a view
  func addCornerRadius(_ cornerRadius: CGFloat) {
    layer.cornerRadius = cornerRadius
    layer.masksToBounds = true
  }
  
  
  // MARK: - Add Border Style
  
  // Customize the border of a view
  func addBorderStyle(borderWidth: CGFloat, borderColor: UIColor) {
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.cgColor
  }
  
  
  // MARK: - Drop-down Shadow
  
  // Add drop down shadow to a view
  func addDropShadow(opacity: Float, radius: CGFloat, offset: CGSize, color: UIColor) {
    
    self.layer.masksToBounds = false
    self.layer.shadowOpacity = opacity
    self.layer.shadowRadius = radius
    self.layer.shadowOffset = offset
    self.layer.shadowColor = color.cgColor
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
  
  // Animate Cell Highlight
  static func animateHighlight(for cell: UICollectionViewCell) {
    
    UIView.animate(withDuration: 0.2, animations: {
      cell.alpha = 0.5
    }) { (_) in
      UIView.animate(withDuration: 0.2) {
        cell.alpha = 1.0
      }}
  }
  
}
