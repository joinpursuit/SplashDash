//
//  MapHistoryView.swift
//  SplashDash
//
//  Created by Sabrina Ip on 3/5/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import SnapKit

class MapHistoryView: UIView, MKMapViewDelegate {
    //MARK: - Properties
    var regionCalculations: (minLat: CLLocationDegrees, minLong: CLLocationDegrees, maxLat: CLLocationDegrees, maxLong: CLLocationDegrees)!
//    let databaseReference: FIRDatabase!
    
    //MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        configureConstraints()
//        setUpMapViewLocation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions

    func datePickerChanged(_ sender: UIDatePicker) {
        print("Date changed to \(self.datePicker.date)")
    }
    
    // MARK: - Setup Views
    
    func setupViewHierarchy() {
        self.addSubview(mapView)
        self.addSubview(datePicker)
    }
    
    func configureConstraints() {
        
        datePicker.snp.remakeConstraints { (view) in
            view.leading.trailing.top.equalToSuperview()
            view.height.equalTo(50.0)
//            view.bottom.equalTo(mapView.snp.top)
        }
        mapView.snp.remakeConstraints { (view) in
            view.leading.trailing.bottom.equalToSuperview()
            //view.height.equalTo(mapView.snp.width)
            view.top.equalTo(datePicker.snp.bottom)
        }
    }
    
//    func setUpMapViewLocation() {
//        //40.730043, -73.991250
//        let center = CLLocationCoordinate2D(latitude: 40.730043, longitude: -73.991250) //40.751085, -73.984946
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
//        self.mapView.setRegion(region, animated: false)
//    }
    
//    func fetchSplashForPickerDate(){
//        self.databaseReference = FIRDatabase.database().reference().child("Public")
//        let linkRef = databaseReference.child(getRootName())
//        
//        linkRef.observe(FIRDataEventType.childAdded, with: { (snapshot) in
//            if let value = snapshot.value as? NSDictionary{
//                if let coor = SplashCoordinate(value){
//                    
//                    //draw all splashes parsed from database
//                    let splash = SplashOverlay(coor: coor)
//                    self.invisibleMapView.addOverlays([splash])
//                    self.mapView.addOverlays([splash])
//                }
//            }
//        })
//    }
    
//    func setMapPinAndRegion() {
//        mapView.removeAnnotations(mapView.annotations)
//        for (index, request) in requests.enumerated() {
//            guard let coordinates = request.coordinates else { continue }
//            
//            let pinAnnotation = RequestMKPointAnnotation()
//            pinAnnotation.coordinate = coordinates
//            
//            if let address = request.incidentAddress {
//                pinAnnotation.title = address
//            } else {
//                pinAnnotation.title = request.createdDate
//            }
//            
//            pinAnnotation.subtitle = request.descriptor
//            
//            pinAnnotation.index = index
//            mapView.addAnnotation(pinAnnotation)
//            
//            if let calc = regionCalculations {
//                if coordinates.latitude < calc.minLat {
//                    regionCalculations?.minLat = coordinates.latitude
//                }
//                if coordinates.latitude > calc.maxLat {
//                    regionCalculations?.maxLat = coordinates.latitude
//                }
//                if coordinates.longitude < calc.minLong {
//                    regionCalculations?.minLong = coordinates.longitude
//                }
//                if coordinates.longitude > calc.maxLong {
//                    regionCalculations?.maxLong = coordinates.longitude
//                }
//            } else {
//                regionCalculations = (minLat: coordinates.latitude, minLong: coordinates.longitude, maxLat: coordinates.latitude, maxLong: coordinates.longitude)
//            }
//            
//            guard let calc = regionCalculations else { return }
//            
//            let midLat = (calc.maxLat + calc.minLat) / 2
//            let midLong = (calc.maxLong + calc.minLong) / 2
//            let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(midLat), longitude: CLLocationDegrees(midLong))
//            
//            let latSpan = calc.maxLat - calc.minLat
//            let longSpan = calc.maxLong - calc.minLong
//            
//            let span = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(latSpan), longitudeDelta: CLLocationDegrees(longSpan))
//            
//            let mkCoordinateRegion = MKCoordinateRegion(center: center, span: span)
//            
//            self.mapView.setRegion(mkCoordinateRegion, animated: true)
//        }
//
//    }
    
    // MARK: - Views

    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.isUserInteractionEnabled = false
        view.showsUserLocation = false
        view.showsScale = true
        view.showsCompass = true
        view.showsBuildings = false
        view.showsPointsOfInterest = false
        view.showsCompass = false
        view.delegate = self
        return view
    }()

    lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        
        let calendar = Calendar.current
        let twoDaysAgo = calendar.date(byAdding: .day, value: -1, to: Date())
        dp.maximumDate = twoDaysAgo
        
        dp.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        return dp
    }()
    
//    lazy var amLabel: UILabel = {
//        let label = UILabel()
//        label.text = "12 AM"
//        
//    }()
    
}
