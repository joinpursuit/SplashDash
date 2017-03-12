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
        
        self.invisibleMapView.setRegion(region, animated: false)
        self.mapView.setRegion(region, animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentUser = currentUser, self.gameStatus
            else { return }
        
        if startLocation == nil {
            startLocation = locations.first
        } else {
            if let lastLocation = locations.last {
                
                // distance
                let distanceInMeters = startLocation.distance(from: lastLocation)
                // convert to miles
                let distanceInMiles = distanceInMeters * 0.000621371
                traveledDistanceInMiles += distanceInMiles
                
                //display in two decimal places
                let distance = String.localizedStringWithFormat("%.2f", traveledDistanceInMiles)
                bottomView.distanceLabel.text = "Distance: \(distance) miles"

                // duration
                let timeSinceStart = lastLocation.timestamp.timeIntervalSince(startLocation.timestamp)
                self.totalDuration += timeSinceStart
                
                // display duration in terms of hours/minutes/seconds
                let hours = Int(self.totalDuration) / 3600
                let minutes = Int(self.totalDuration) / 60 % 60
                let seconds = Int(self.totalDuration) % 60
                let durationString = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
                bottomView.durationLabel.text = "Duration: \(durationString)"
                
                //the average human can run at the speed of 15 miles per hour for short periods of time.
                var currentSpeed = lastLocation.speed as Double
                if currentSpeed < 0 {
                    currentSpeed = Double(arc4random_uniform(500) + 500)/100
                }
                
                //            print(location.coordinate.latitude)
                //            print(location.coordinate.longitude)
                //            print(currentSpeed)
                //            print(location.timestamp.timeIntervalSince1970)
                //            print("")
                
                let currentUserId = currentUser.uid
                let coordinate = SplashCoordinate(userID: currentUserId, midCoordinate: lastLocation.coordinate, speed: currentSpeed, teamName: currentUser.teamName, splashImageTag: 1, timestamp: lastLocation.timestamp.timeIntervalSince1970)
                
                //push coordinate to firebase
                self.currentRun.addCoordinate(coor: coordinate)
                pushSplashToDatabase(coor: coordinate)
                
                let region = MKCoordinateRegion(center: lastLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                self.mapView.setRegion(region, animated: true)
                
            }
        }
        startLocation = locations.last
    }
}
