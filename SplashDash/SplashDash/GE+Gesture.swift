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
    
    func displayViewTapped(sender: UIGestureRecognizer) {
        self.bottomViewIsUp = false
    }
    
    // MARK: - Pan Gesture Recognizer
    
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let movingView = gestureRecognizer.view else { return }
        
        let spacing = bottomView.topViewSpacing
        let snapBuffer: CGFloat = 30.0
        var startTime = Date()
        
        switch gestureRecognizer.state {
        case .began:
            self.bottomViewPreviousPosition = movingView.center.y
            startTime = Date()
        case .changed:
            let translation = gestureRecognizer.translation(in: self.view)
            movingView.center = CGPoint(x: movingView.center.x, y: movingView.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        case .ended:
            let duration = Date().timeIntervalSince(startTime) + 0.2
            if movingView.center.y - movingView.frame.height/2 < spacing + snapBuffer {
                UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {
                    movingView.center = CGPoint(x: movingView.center.x, y: spacing + movingView.frame.height/2)
                    gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                    self.bottomViewIsUp = true
                }, completion: nil)
                return }
            else if movingView.center.y - movingView.frame.height/2 > self.view.frame.height - spacing - snapBuffer {
                UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {
                    movingView.center = CGPoint(x: movingView.center.x, y: self.view.frame.height + movingView.frame.height/2 - spacing)
                    gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                    self.bottomViewIsUp = false
                }, completion: nil)
                return
            }
                // Min Y
            else if movingView.center.y < self.bottomViewPreviousPosition {
                self.bottomViewIsUp = true
                return }
                // Max Y
            else {
                self.bottomViewIsUp = false
                return
            }
        default: return
        }
    }
}
