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
        locationManager.distanceFilter = 15
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let center = CLLocationCoordinate2D(latitude: 40.751085, longitude: -73.984946)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
        
//        self.invisibleMapView.setRegion(region, animated: false)
        self.mapView.setRegion(region, animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentUser = currentUser, self.gameStatus, let currentLocation = locations.last
            else {
               // previousLocation = locations.last
                return }
        
        // Only splash when every 60 meters, starting at the 15 meters mark
        if distanceFilterIncrement == 1 {
            //the average human can run at the speed of 15 miles per hour (or 6.7056 meters per second) for short periods of time.
            
            // currentSpeed is in meters per second
            var currentSpeed = currentLocation.speed as Double
            
            // range speed for gpx files
            if currentSpeed == -1 {
                // setting speed to range between 1.25 m/s to 6.25 m/s (walking speed)
                currentSpeed = Double(arc4random_uniform(525) + 125)/100
            }
            
            let currentUserId = currentUser.uid
            let coordinate = SplashCoordinate(userID: currentUserId, midCoordinate: currentLocation.coordinate, speed: currentSpeed, teamName: currentUser.teamName, splashImageTag: 1, timestamp: currentLocation.timestamp.timeIntervalSince1970)
            
            //push coordinate to firebase
            self.currentRunCoordinates.append(coordinate)
            pushSplashToDatabase(coor: coordinate)
        }
        
        if previousLocation != nil {
                // distance (in meters)
                var distanceInMeters = previousLocation.distance(from: currentLocation)
                
                // error handling
                if distanceInMeters > 2 * locationManager.distanceFilter {
                    distanceInMeters = locationManager.distanceFilter
                }
                
                traveledDistanceInMeters += distanceInMeters
        }
        // current location becomes the start location
        previousLocation = locations.last
        distanceFilterIncrement += 1
        if distanceFilterIncrement >= 4 {
            distanceFilterIncrement = 0
        }
    }
}
