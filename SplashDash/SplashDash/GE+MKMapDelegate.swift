//
//  GE+MKMapDelegate.swift
//  SplashDash
//
//  Created by Tong Lin on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import Foundation
import MapKit

extension GameViewController: MKMapViewDelegate{
    
    func drawPolyLine(with location: CLLocationCoordinate2D) {
        
        let myPolyline = MKPolyline(coordinates: [lastLocation, location], count: 2)
        lastLocation = location
        mapView.add(myPolyline)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            
        } else if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.lineWidth = CGFloat(Int(arc4random_uniform(15) + 5))
            lineView.strokeColor = .green
            lineView.miterLimit = 0
            lineView.lineDashPhase = 100
            return lineView
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
    
    
}
