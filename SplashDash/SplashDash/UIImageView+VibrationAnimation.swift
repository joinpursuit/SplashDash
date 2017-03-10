//
//  UIImageView+VibrationAnimation.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/10/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit

extension UIImageView {
    func vibrationAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: self.center.x - 2,
                                      y: self.center.y)
        animation.toValue = CGPoint(x: self.center.x + 2,
                                    y: self.center.y)
        self.layer.add(animation, forKey: "position")
    }
}
