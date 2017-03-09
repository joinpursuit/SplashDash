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
    var teamName: String
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
    
    init(overlay: MKOverlay, teamName: String, splashImageTag: Int) {
        //switch to choose color and shape
        
        self.overlayImage = UIImage(named: "inkSample3")!
        super.init(overlay: overlay)
    }
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        let imageReference = overlayImage.cgImage
        
        let theMapRect = overlay.boundingMapRect
        let theRect = rect(for: theMapRect)
        
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -theRect.size.height)
//        context.rotate(by: CGFloat(arc4random_uniform(181))/360)
        context.draw(imageReference!, in: theRect)
    }
}
