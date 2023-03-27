///
/// LoadScreen.swift
///
/// Created by Cristina Dobson
///


import UIKit


class LoadScreen: UIView {

  
  // MARK: - Properties
  
  let animationKey = "rotation"
  
  @IBOutlet weak var soccerBall: UIImageView!

  
  // MARK: - Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    startRotatingView(soccerBall)
  }
  
  
  // MARK: - Animation Methods
  
  func stopAnimation() {
    stopRotatingView(soccerBall)
  }
  
  // Start the rotating ball animation
  func startRotatingView(_ imageView: UIImageView) {
    
    let animation = CABasicAnimation(keyPath: "transform.rotation")
    animation.duration = 2
    animation.repeatCount = Float.infinity
    animation.fromValue = 0.0
    animation.toValue = Float(Double.pi * 2.0)
    
    imageView.layer.add(animation, forKey: animationKey)
  }
  
  // Stop the rotating ball animation
  func stopRotatingView(_ imageView: UIImageView) {
    imageView.layer.removeAnimation(forKey: animationKey)
  }
  

}
