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
    
}
