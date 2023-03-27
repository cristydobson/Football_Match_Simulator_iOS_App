///
/// GoalView.swift
///
/// This bar is displayed
/// every time a team scores a goal
///
/// Created by Cristina Dobson
///


import Foundation
import UIKit


class GoalView: UIView {
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: Setup Methods
  
  // Add views to be displayed
  func addViews() {
    
    // Background Image
    setupBackgroundBar()
    
    
    // Ball Image
    let ball = getImageView(for: "soccer-ball")
    addSubview(ball)
    
    
    // Goal Label
    let label = getGoalLabel()
    addSubview(label)
    
    // Container Stack View
    let stackView = getStackView()
    stackView.spacing = 12
    addSubview(stackView)
    
    stackView.addArrangedSubview(ball)
    stackView.addArrangedSubview(label)

    NSLayoutConstraint.activate([
      
      // Ball
      ball.setHeightContraint(by: 50),
      ball.widthAnchor.constraint(
        equalTo: ball.heightAnchor, multiplier: 1),
      
      // Container Stack View
      stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
      
    ])
    
  }
  
  
  // MARK: - Background Bar
  
  func setupBackgroundBar() {
    let imageView = getImageView(for: "Goal_bar")
    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  
  // MARK: - View Helper Methods
  
  func getImageView(for image: String) -> UIImageView {
    let imageView = ViewHelper.createImageView(
      contentMode: .scaleAspectFill)
    imageView.image = UIImage(named: image)
    
    return imageView
  }
  
  func getGoalLabel() -> UILabel {
    let label = ViewHelper.createLabel(
      with: .white,
      text: "GOOOOOOOOOAL!!!",
      alignment: .center,
      font: UIFont.systemFont(ofSize: 36, weight: .bold))
    
    return label
  }
  
  func getStackView() -> UIStackView {
    return ViewHelper.createStackView(
      .horizontal, distribution: .fill)
  }
  
}
