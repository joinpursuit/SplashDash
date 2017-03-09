//
//  SplashOverlayView.swift
//  SplashDash
//
//  Created by Tong Lin on 3/2/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import MapKit

class SplashOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    var teamName: UserTeam
    var splashImageTag: Int
    
    init(coor: SplashCoordinate) {
        boundingMapRect = coor.overlayBoundingMapRect
        coordinate = coor.midCoordinate
        teamName = coor.teamName
        splashImageTag = coor.splashImageTag
        
        
    }
}

class SplashOverlayView: MKOverlayRenderer {
    var overlayImage: UIImage
    
    init(overlay: MKOverlay, teamName: UserTeam, splashImageTag: Int) {
        //switch to choose color and shape
        let splash = UIImage(named: "inkSample3")!
        
        switch teamName {
        case .purple:
            self.overlayImage = splash.imageWithColor(color1: SplashColor.teamColor(for: "purpleTeamColor"))
        case .teal:
            self.overlayImage = splash.imageWithColor(color1: SplashColor.teamColor(for: "tealTeamColor"))
        case .green:
            self.overlayImage = splash.imageWithColor(color1: SplashColor.teamColor(for: "greenTeamColor"))
        case .orange:
            self.overlayImage = splash.imageWithColor(color1: SplashColor.teamColor(for: "orangeTeamColor"))
        }
        
        super.init(overlay: overlay)
    }
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        let imageReference = overlayImage.cgImage
        
        let theMapRect = overlay.boundingMapRect
        let theRect = rect(for: theMapRect)
        
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -theRect.size.height)
        context.draw(imageReference!, in: theRect)
    }
}

extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
