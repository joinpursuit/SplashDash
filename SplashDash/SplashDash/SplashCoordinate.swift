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
    
//    var boundary: [CLLocationCoordinate2D]
    let userID: String
    let midCoordinate: CLLocationCoordinate2D
    let speed: Double
    let teamColor: UIColor
    let splashImageTag: Int
    let head: Bool
    
    var overlayTopLeftCoordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: midCoordinate.latitude+speed, longitude: midCoordinate.longitude-speed)
        }
    }
    var overlayTopRightCoordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: midCoordinate.latitude+speed, longitude: midCoordinate.longitude+speed)
        }
    }
    var overlayBottomLeftCoordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: midCoordinate.latitude-speed, longitude: midCoordinate.longitude-speed)
        }
    }
    var overlayBottomRightCoordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: midCoordinate.latitude-speed, longitude: midCoordinate.longitude+speed)
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
    
    init(userID: String, midCoordinate: CLLocationCoordinate2D, speed: Double, teamColor: UIColor, head: Bool, splashImageTag: Int) {
        self.userID = userID
        self.midCoordinate = midCoordinate
        self.speed = speed
        self.teamColor = teamColor
        self.head = head
        self.splashImageTag = splashImageTag
    }
    
    func toData() -> [String: Any]{
        return ["userID": self.userID,
            "midCoordinate": self.midCoordinate,
            "speed": self.speed,
            "teamColor": self.teamColor,
            "head": self.head,
            "splashImageTag": self.splashImageTag] as [String: Any]
    }
    
}
