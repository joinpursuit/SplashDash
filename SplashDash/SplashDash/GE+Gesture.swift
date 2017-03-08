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
    
    // 105 is an arbitrary number
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let spacing = bottomView.topViewSpacing
        
        guard let allMovingViews = gestureRecognizer.view?.superview,
            let movingView = gestureRecognizer.view else { return }
        
        let heightDiff = allMovingViews.frame.height - movingView.frame.height
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: self.view)
            
            print("allMovingViews.center.y: \(allMovingViews.center.y)")
            print("allMovingViews.frame.height/2 \(allMovingViews.frame.height/2)")
            print("movingView.center.y \(movingView.center.y)")
            print("movingView.frame.height/2 \(movingView.frame.height/2)")
            
            
            if allMovingViews.center.y - allMovingViews.frame.height/2 < spacing {
                
                allMovingViews.center = CGPoint(x: allMovingViews.center.x, y: spacing + allMovingViews.frame.height/2)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                
                return }
            
            if allMovingViews.center.y - allMovingViews.frame.height/2 > self.view.frame.height - spacing {
                
                allMovingViews.center = CGPoint(x: allMovingViews.center.x, y: self.view.frame.height + allMovingViews.frame.height/2 - spacing)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                
                return
            }
            
            allMovingViews.center = CGPoint(x: allMovingViews.center.x, y: allMovingViews.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
    }
}
