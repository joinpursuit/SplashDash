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
        self.backgroundColor = .white
        setupViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewHierarchy(){
        self.addSubview(singleRunMap)
        self.addSubview(distanceLabel)
        self.addSubview(durationLabel)
        self.addSubview(speedLabel)
        self.addSubview(distanceNumLabel)
        self.addSubview(durationNumLabel)
        self.addSubview(speedNumLabel)
        self.addSubview(seperatorLine)
        self.addSubview(timeLabel)
        self.addSubview(dateLabel)
    }
    
    func configureConstraints(){
        singleRunMap.snp.makeConstraints { (view) in
            view.top.leading.trailing.equalToSuperview()
            view.bottom.equalTo(dateLabel.snp.top).offset(-8.0)
        }
        
        distanceLabel.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.bottom.equalToSuperview().inset(8.0)
        }
        
        durationLabel.snp.makeConstraints { (view) in
            view.leading.equalToSuperview().inset(24.0)
            view.bottom.equalToSuperview().inset(8.0)
        }
        
        speedLabel.snp.makeConstraints { (view) in
            view.trailing.equalToSuperview().inset(24.0)
            view.bottom.equalToSuperview().inset(8.0)
        }
        
        distanceNumLabel.snp.makeConstraints { (view) in
            view.centerX.equalTo(distanceLabel)
            view.bottom.equalTo(distanceLabel.snp.top).offset(-8.0)
        }
        
        durationNumLabel.snp.makeConstraints { (view) in
            view.centerX.equalTo(durationLabel)
            view.bottom.equalTo(durationLabel.snp.top).offset(-8.0)
        }
        
        speedNumLabel.snp.makeConstraints { (view) in
            view.centerX.equalTo(speedLabel)
            view.bottom.equalTo(speedLabel.snp.top).offset(-8.0)
        }
        
        seperatorLine.snp.makeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            view.height.equalTo(1.0)
            view.bottom.equalTo(distanceNumLabel.snp.top).offset(-8.0)
        }
        
        timeLabel.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.bottom.equalTo(seperatorLine.snp.top).offset(-8.0)
        }
        
        dateLabel.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.bottom.equalTo(timeLabel.snp.top).offset(-8.0)
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
        
        let latSpan = maxLat - minLat
        let longSpan = maxLong - minLong
        var maxSpan = latSpan > longSpan ? latSpan : longSpan
        maxSpan += 0.005
        
        let span = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(maxSpan), longitudeDelta: CLLocationDegrees(maxSpan))
        
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
    
    private lazy var seperatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = SplashColor.primaryColor(alpha: 0.3)
        return view
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        var labelText = "Duration"
        label.text = labelText
        label.textColor = SplashColor.primaryColor()
        label.numberOfLines = 0
        label.font = label.font.withSize(13)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        var labelText = "Distance"
        label.text = labelText
        label.textColor = SplashColor.primaryColor()
        label.numberOfLines = 0
        label.font = label.font.withSize(13)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    private lazy var speedLabel: UILabel = {
        let label = UILabel()
        var labelText = "Avg. Speed (mph)"
        label.text = labelText
        label.textColor = SplashColor.primaryColor()
        label.numberOfLines = 0
        label.font = label.font.withSize(13)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var durationNumLabel: UILabel = {
        let label = UILabel()
        var labelText = "0"
        label.text = labelText
        label.textColor = SplashColor.primaryColor()
        label.numberOfLines = 0
        label.font = label.font.withSize(24)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var distanceNumLabel: UILabel = {
        let label = UILabel()
        var labelText = "0"
        label.text = labelText
        label.textColor = SplashColor.primaryColor()
        label.numberOfLines = 0
        label.font = label.font.withSize(24)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var speedNumLabel: UILabel = {
        let label = UILabel()
        var labelText = "0"
        label.text = labelText
        label.textColor = SplashColor.primaryColor()
        label.numberOfLines = 0
        label.font = label.font.withSize(24)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        var labelText = "0:00 am"
        label.text = labelText
        label.textColor = SplashColor.primaryColor()
        label.numberOfLines = 0
        label.font = label.font.withSize(13)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        var labelText = "MM/DD/YY"
        label.text = labelText
        label.textColor = SplashColor.primaryColor()
        label.numberOfLines = 0
        label.font = label.font.withSize(24)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
}
