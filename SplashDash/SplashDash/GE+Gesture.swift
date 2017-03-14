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
    
    // MARK: - Pan Gesture Recognizer
    
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let movingView = gestureRecognizer.view else { return }
        
        let spacing = bottomView.topViewSpacing
        let snapBuffer: CGFloat = 30.0
        
        switch gestureRecognizer.state {
        case .began:
            self.bottomViewPreviousPosition = movingView.center.y
        case .changed:
            let translation = gestureRecognizer.translation(in: self.view)
            movingView.center = CGPoint(x: movingView.center.x, y: movingView.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        case .ended:
            // don't change position if change is within buffer
            
            if movingView.center.y - movingView.frame.height/2 < spacing + snapBuffer {
                movingView.center = CGPoint(x: movingView.center.x, y: spacing + movingView.frame.height/2)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                self.bottomViewIsUp = true
                return }
            else if movingView.center.y - movingView.frame.height/2 > self.view.frame.height - spacing - snapBuffer {
                movingView.center = CGPoint(x: movingView.center.x, y: self.view.frame.height + movingView.frame.height/2 - spacing)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                self.bottomViewIsUp = false
                return
            }
                // Min Y
            else if movingView.center.y < self.bottomViewPreviousPosition {
                movingView.center = CGPoint(x: movingView.center.x, y: spacing + movingView.frame.height/2)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                self.bottomViewIsUp = true
                return }
                // Max Y
            else {
                movingView.center = CGPoint(x: movingView.center.x, y: self.view.frame.height + movingView.frame.height/2 - spacing)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                self.bottomViewIsUp = false
                return
            }
        default: return
        }
    }

    
//    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
//        guard let allMovingViews = gestureRecognizer.view?.superview,
//            let movingView = gestureRecognizer.view else { return }
//        
//        let spacing = bottomView.topViewSpacing
//        let heightDiff = allMovingViews.frame.height - movingView.frame.height
//        let snapBuffer: CGFloat = 30.0
//        
//        switch gestureRecognizer.state {
//        case .began:
//            self.bottomViewPreviousPosition = allMovingViews.center.y
//        case .changed:
//            let translation = gestureRecognizer.translation(in: self.view)
//            allMovingViews.center = CGPoint(x: allMovingViews.center.x, y: allMovingViews.center.y + translation.y)
//            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
//        case .ended:
//            // don't change position if change is within buffer
//            
//            if allMovingViews.center.y - allMovingViews.frame.height/2 < spacing - heightDiff + snapBuffer {
//                allMovingViews.center = CGPoint(x: allMovingViews.center.x, y: spacing - heightDiff + allMovingViews.frame.height/2)
//                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
//                return }
//            else if allMovingViews.center.y - allMovingViews.frame.height/2 > self.view.frame.height - spacing - heightDiff - snapBuffer {
//                allMovingViews.center = CGPoint(x: allMovingViews.center.x, y: self.view.frame.height + allMovingViews.frame.height/2 - spacing - heightDiff)
//                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
//                return
//            }
//            // Min Y
//            else if allMovingViews.center.y < self.bottomViewPreviousPosition {
//                allMovingViews.center = CGPoint(x: allMovingViews.center.x, y: spacing - heightDiff + allMovingViews.frame.height/2)
//                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
//                return }
//            // Max Y
//            else {
//                allMovingViews.center = CGPoint(x: allMovingViews.center.x, y: self.view.frame.height + allMovingViews.frame.height/2 - spacing - heightDiff)
//                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
//                return
//            }
//        default: return
//        }
//    }
}
