//
//  GE+Gesture.swift
//  SplashDash
//
//  Created by Tong Lin on 3/2/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import MapKit

extension GameViewController{

//    func addGestures(){
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOnMap(sender:)))
//        tap.numberOfTapsRequired = 1
//        mapView.addGestureRecognizer(tap)
//    }
    
    func tappedOnMap(sender: UIGestureRecognizer) {
        guard let tapGesture: UITapGestureRecognizer = sender as? UITapGestureRecognizer else { return }
        switch (tapGesture.numberOfTapsRequired, tapGesture.numberOfTouchesRequired) {
        case (1, 1):
            print("Map was tapped once, with one finger")
            self.animateAllButtons()
        default:
            print("Map was tapped, but not with one finger!")
        }
        
    }
    
    // MARK: - Pan Gesture Recognizer
    
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let allMovingViews = gestureRecognizer.view?.superview,
            let movingView = gestureRecognizer.view else { return }
        
        let spacing = bottomView.topViewSpacing
        let heightDiff = allMovingViews.frame.height - movingView.frame.height
        let snapBuffer: CGFloat = 100.0
        
        switch gestureRecognizer.state {
        case .changed:
            let translation = gestureRecognizer.translation(in: self.view)
            allMovingViews.center = CGPoint(x: allMovingViews.center.x, y: allMovingViews.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
            
        case .ended:
            // Min Y
            if allMovingViews.center.y - allMovingViews.frame.height/2 < spacing - heightDiff + snapBuffer {
                allMovingViews.center = CGPoint(x: allMovingViews.center.x, y: spacing - heightDiff + allMovingViews.frame.height/2)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                return }
            
            // Max Y
            if allMovingViews.center.y - allMovingViews.frame.height/2 > self.view.frame.height - spacing - heightDiff - snapBuffer {
                allMovingViews.center = CGPoint(x: allMovingViews.center.x, y: self.view.frame.height + allMovingViews.frame.height/2 - spacing - heightDiff)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                return
            }
        default: return
        }
    }
}
