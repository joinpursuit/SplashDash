//
//  GE+CoreLocationDelegate.swift
//  SplashDash
//
//  Created by Tong Lin on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension GameViewController: CLLocationManagerDelegate{
    
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
        print(location.speed)
        print(location.timestamp.timeIntervalSince1970)
        print("")
        //the average human can run at the speed of 15 miles per hour for short periods of time.
        if self.gameStatus{
            let coordinate = SplashCoordinate(userID: "uid", midCoordinate: location.coordinate, speed: location.speed, teamName: "Wolfpack", splashImageTag: 1)
            let splash = SplashOverlay(park: coordinate)
            mapView.addOverlays([splash])
        }   
    }
}
