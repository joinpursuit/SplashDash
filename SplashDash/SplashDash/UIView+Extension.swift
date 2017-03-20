//
//  UIView+Extension.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/2/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit

extension UIView {
    func addShadows() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
    }
    
    func removeShadows() {
        self.layer.shadowOpacity = 0
    }
}
