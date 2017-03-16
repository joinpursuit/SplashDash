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

class SingleRunMapView: UIView, MKMapViewDelegate {

    var splashOverlay: [SplashOverlay] = [] {
        didSet(value){
            //do something
            configureConstraints()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewHierarchy(){
        self.addSubview(singleRunMapView)
    }
    func configureConstraints(){
        singleRunMapView.snp.makeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
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
    lazy var singleRunMapView: MKMapView = {
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
