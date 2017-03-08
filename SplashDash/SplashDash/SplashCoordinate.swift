//
//  SplashCoordinate.swift
//  SplashDash
//
//  Created by Tong Lin on 3/2/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import Foundation
import MapKit

class SplashCoordinate {
    
    let userID: String
    let midCoordinate: CLLocationCoordinate2D
    let speed: Double
    let teamName: String
    let splashImageTag: Int
    let timestamp: Double
    
    init(userID: String, midCoordinate: CLLocationCoordinate2D, speed: Double, teamName: String, splashImageTag: Int, timestamp: Double) {
        self.userID = userID
        self.midCoordinate = midCoordinate
        self.speed = speed
        self.teamName = teamName
        self.splashImageTag = splashImageTag
        self.timestamp = timestamp
    }
    
    convenience init?(_ validDict: NSDictionary) {
        guard let userID = validDict["userID"] as? String,
            let speed = validDict["speed"] as? Double,
            let teamName = validDict["teamName"] as? String,
            let splashImageTag = validDict["splashImageTag"] as? Int,
            let timestamp = validDict["timestamp"] as? Double,
            let longitude = validDict["longitude"] as? Double,
            let latitude = validDict["latitude"] as? Double  else {
                print("!!!!!Error parsing coordinates!!!!!")
                return nil
        }
        
        let midCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        self.init(userID: userID, midCoordinate: midCoordinate, speed: speed, teamName: teamName, splashImageTag: splashImageTag, timestamp: timestamp)
    }
    
    var adjustedRatio: Double {
        get{
            return speed/6000
        }
    }
    var teamColor: UIColor {
        get{
            //switch on team name and return corresponding color
            return UIColor.red
        }
    }
    var overlayTopLeftCoordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: midCoordinate.latitude+adjustedRatio, longitude: midCoordinate.longitude-adjustedRatio)
        }
    }
    var overlayTopRightCoordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: midCoordinate.latitude+adjustedRatio, longitude: midCoordinate.longitude+adjustedRatio)
        }
    }
    var overlayBottomLeftCoordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: midCoordinate.latitude-adjustedRatio, longitude: midCoordinate.longitude-adjustedRatio)
        }
    }
    var overlayBottomRightCoordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: midCoordinate.latitude-adjustedRatio, longitude: midCoordinate.longitude+adjustedRatio)
        }
    }
    
    var overlayBoundingMapRect: MKMapRect {
        get {
            let topLeft = MKMapPointForCoordinate(overlayTopLeftCoordinate)
            let topRight = MKMapPointForCoordinate(overlayTopRightCoordinate)
            let bottomLeft = MKMapPointForCoordinate(overlayBottomLeftCoordinate)
            
            return MKMapRectMake(topLeft.x,
                                 topLeft.y,
                                 fabs(topLeft.x-topRight.x),
                                 fabs(topLeft.y - bottomLeft.y))
        }
    }
    
    func toData() -> [String: Any]{
        return ["userID": self.userID,
                "latitude": self.midCoordinate.latitude,
                "longitude": self.midCoordinate.longitude,
                "speed": self.speed,
                "teamName": self.teamName,
                "splashImageTag": self.splashImageTag,
                "timestamp": self.timestamp] as [String: Any]
    }
    
}
