//
//  SplashSKView.swift
//  SplashDash
//
//  Created by Tong Lin on 3/13/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SpriteKit

class SplashSKView: SKView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if (!self.clipsToBounds && !self.isHidden && self.alpha > 0.0) {
            let subviews = self.subviews.reversed()
            for member in subviews {
                let subPoint = member.convert(point, from: self)
                if let result:UIView = member.hitTest(subPoint, with:event) {
                    return result;
                }
            }
        }
        return nil
        
//        let hitView = super.hitTest(point, with: event)
//        
//        if hitView != nil{
//            self.superview?.bringSubview(toFront: self)
//        }
//        return hitView
    }
    
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        let rect = self.bounds
//        
//        var isInside = rect.contains(point)
//        
//        if !isInside{
//            for view in self.subviews{
//                isInside = view.frame.contains(point)
//                if isInside{
//                    break
//                }
//            }
//        }
//        
//        return isInside
//    }
}
