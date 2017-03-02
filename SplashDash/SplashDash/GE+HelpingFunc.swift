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
    func updateGameStatus(){
        if self.gameStatus{
            gameButton.setTitle("Start", for: .normal)
            filCol = Int(arc4random_uniform(UInt32(color.count)))
        }else{
            if let current = self.locationManager.location{
                let center = CLLocationCoordinate2D(latitude: current.coordinate.latitude, longitude: current.coordinate.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
                
                self.mapView.setRegion(region, animated: true)
            }
            gameButton.setTitle("Stop", for: .normal)
        }
        
        self.gameStatus = !self.gameStatus
    }
    
    
}
