//
//  GE+HelpingFunc.swift
//  SplashDash
//
//  Created by Tong Lin on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension GameViewController{
    
//    func updateGameStatus(){
    func startButtonTapped() {
        if self.gameStatus{
            gameButton.setTitle("Start", for: .normal)
        }else{
            toCurrentLocation()
            gameButton.setTitle("Stop", for: .normal)
            animateAllButtons()
        }
        
        gameStatus = !gameStatus
    }
    
    func toCurrentLocation(){
        if let current = self.locationManager.location{
            let center = CLLocationCoordinate2D(latitude: current.coordinate.latitude, longitude: current.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func animateAllButtons(){
        UIView.animate(withDuration: 0.8, animations: {
            if self.isButtonsOffScreen{
                self.gameButton.transform = CGAffineTransform(translationX: 0, y: 0)
                self.findMeButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }else{
                self.gameButton.transform = CGAffineTransform(translationX: 150, y: 0)
                self.findMeButton.transform = CGAffineTransform(translationX: 150, y: 0)
            }
            self.isButtonsOffScreen = !self.isButtonsOffScreen
        }, completion: nil)
    }
    
    // MARK: - Pan Gesture Recognizer
    
    // 105 is an arbitrary number
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer, spacing: CGFloat = 105) {
        let spacing = bottomView.topView.frame.height
        
        guard let movingView = gestureRecognizer.view else { return }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            if movingView.center.y - movingView.frame.height/2 < spacing {
                
                movingView.center = CGPoint(x: movingView.center.x, y: spacing + movingView.frame.height/2)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                
                return }
            
            if movingView.center.y - movingView.frame.height/2 > self.view.frame.height - spacing {
                
                movingView.center = CGPoint(x: movingView.center.x, y: self.view.frame.height + movingView.frame.height/2 - spacing)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                
                return
            }
            
            movingView.center = CGPoint(x: movingView.center.x, y: movingView.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
    }
}
