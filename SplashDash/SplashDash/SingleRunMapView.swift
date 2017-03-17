//
//  SingleRunMapView.swift
//  SplashDash
//
//  Created by Tong Lin on 3/15/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation

class SingleRunMapView: UIView, MKMapViewDelegate {

    private var splashOverlay: [SplashOverlay] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewHierarchy(){
        self.addSubview(singleRunMap)
    }
    
    func configureConstraints(){
        singleRunMap.snp.makeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func zoomingMap(fit overlays: [SplashOverlay]){
        self.splashOverlay = overlays
        self.singleRunMap.addOverlays(self.splashOverlay)
        self.setMapPinAndRegion()
    }
    
    func mapDeconstruction(){
        //remove all overlays
        singleRunMap.removeOverlays(self.splashOverlay)
        self.splashOverlay = []
    }
    
    private func setMapPinAndRegion() {
        
        var minLat: CLLocationDegrees = 85
        var maxLat: CLLocationDegrees = -85
        var minLong: CLLocationDegrees = 180
        var maxLong: CLLocationDegrees = -180
        
        for coordinate in self.splashOverlay.map({ $0.coordinate }){
            
            if coordinate.latitude < minLat {
                minLat = coordinate.latitude
            }
            if coordinate.latitude > maxLat {
                maxLat = coordinate.latitude
            }
            if coordinate.longitude < minLong {
                minLong = coordinate.longitude
            }
            if coordinate.longitude > maxLong {
                maxLong = coordinate.longitude
            }
        }
        
        let midLat = (maxLat + minLat) / 2
        let midLong = (maxLong + minLong) / 2
        let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(midLat), longitude: CLLocationDegrees(midLong))
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        self.singleRunMap.setRegion(MKCoordinateRegion(center: center, span: span), animated: false)
    }
    
    //MARK: - MKMapView delegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let myOverlay = overlay as? SplashOverlay{
            let splashOverlay = SplashOverlayView(overlay: myOverlay, teamName: myOverlay.teamName, splashImageTag: myOverlay.splashImageTag)
            return splashOverlay
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
    //MARK: - Lazy inits:
    lazy var singleRunMap: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.isZoomEnabled = false
        view.isScrollEnabled = false
        view.isRotateEnabled = false
        view.isPitchEnabled = false
        view.showsCompass = false
        view.showsScale = false
        view.showsPointsOfInterest = false
        view.showsBuildings = false
        view.showsTraffic = false
        view.showsUserLocation = false
        view.delegate = self
        view.isUserInteractionEnabled = false
        return view
    }()
}
