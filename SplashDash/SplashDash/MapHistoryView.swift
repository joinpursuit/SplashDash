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
    var locationManager: CLLocationManager!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        configureConstraints()
        setUpMapViewLocation()
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
    
    //MARK: - Methods
    func setUpMapViewLocation() {
        //40.725128, -73.995064
        let center = CLLocationCoordinate2D(latitude: 40.725128, longitude: -73.995064) //40.751085, -73.984946
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.08))
        self.mapView.setRegion(region, animated: false)

    }
    
    // MARK: - Views

    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
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
        dp.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        return dp
    }()
    
//    lazy var amLabel: UILabel = {
//        let label = UILabel()
//        label.text = "12 AM"
//        
//    }()
    
}
