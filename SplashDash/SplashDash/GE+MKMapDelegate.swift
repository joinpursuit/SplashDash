//
//  GE+MKMapDelegate.swift
//  SplashDash
//
//  Created by Tong Lin on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import MapKit

extension GameViewController: MKMapViewDelegate{
    
    func setupMapView(){
        let overlayPath = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
        let overlay = MKTileOverlay(urlTemplate: overlayPath)
        overlay.canReplaceMapContent = true
        self.mapView.add(overlay)
    }
    
//    func drawPolyLine(with location: CLLocationCoordinate2D) {
//        let myPolyline = MKPolyline(coordinates: [lastLocation, location], count: 2)
//        lastLocation = location
//        mapView.add(myPolyline)
//    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let myOverlay = overlay as? SplashOverlay{
            let splashOverlay = SplashOverlayView(overlay: myOverlay, teamName: myOverlay.teamName, splashImageTag: myOverlay.splashImageTag)
            return splashOverlay
        }
//        else if overlay is MKCircle{
//            let circleRenderer = MKCircleRenderer(overlay: overlay)
//            circleRenderer.fillColor = .orange
//            return circleRenderer
//        } else if overlay is MKPolyline {
//            let lineView = MKPolylineRenderer(overlay: overlay)
//            lineView.lineWidth = CGFloat(Int(arc4random_uniform(15) + 5))
//            lineView.strokeColor = .green
//            lineView.miterLimit = 0
//            lineView.lineDashPhase = 100
//            return lineView
//        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
//    func mapView(_ mapView: MKMapView, didAdd renderers: [MKOverlayRenderer]) {
//        switch mapView {
//        case self.mapView:
//            if gameStatus {
//                for layer in renderers{
//                    if let thisLayer = layer as? SplashOverlayView{
//                        let point = mapView.convert(layer.overlay.coordinate, toPointTo: self.view)
//                        scene.dropSplash(on: point, with: thisLayer.overlayImage)
//                    }
//                    
//                }
//            }
//        default: ()
//        }
//    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //Map camera will follow user's location after game started
        if gameStatus{
            self.mapView.setCenter(userLocation.coordinate, animated: true)
        }
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        switch mapView {
        case invisibleMapView:
            //init ranking labels at current time
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                self.takeScreenshot()
            })
        default:
            return
        }
    }
}
