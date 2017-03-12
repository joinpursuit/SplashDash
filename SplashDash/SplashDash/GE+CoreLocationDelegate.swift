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
import Firebase

extension GameViewController: CLLocationManagerDelegate{
    
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 50
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let center = CLLocationCoordinate2D(latitude: 40.738468, longitude: -73.991808)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
        
        self.mapView.setRegion(region, animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last,
            let currentUser = currentUser else { return }
        //the average human can run at the speed of 15 miles per hour for short periods of time.
        if self.gameStatus {
            var currentSpeed = location.speed as Double
            if currentSpeed < 0 {
                currentSpeed = Double(arc4random_uniform(500) + 500)/100
            }
//            print(location.coordinate.latitude)
//            print(location.coordinate.longitude)
//            print(currentSpeed)
//            print(location.timestamp.timeIntervalSince1970)
//            print("")

            let currentUserId = currentUser.uid
            let coordinate = SplashCoordinate(userID: currentUserId, midCoordinate: location.coordinate, speed: currentSpeed, teamName: currentUser.teamName, splashImageTag: 1, timestamp: location.timestamp.timeIntervalSince1970)
            
            //push coordinate to firebase
            self.currentRun.addCoordinate(coor: coordinate)
            pushSplashToDatabase(coor: coordinate)
            
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.mapView.setRegion(region, animated: true)
        }
    }
}
