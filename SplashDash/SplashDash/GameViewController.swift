//
//  GameViewController.swift
//  SplashDash
//
//  Created by Tong Lin on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class GameViewController: UIViewController {

    let databaseReference = FIRDatabase.database().reference()
    
    var locationManager: CLLocationManager!
    var lastLocation: CLLocationCoordinate2D!
    var gameStatus: Bool = false
    
    let color = [UIColor.red, UIColor.green, UIColor.blue, UIColor.cyan]
    var filCol: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewHierarchy()
        configureConstraints()
    }

    func setupViewHierarchy(){
        view.addSubview(mapView)
        view.addSubview(gameButton)
        
//        setupMapView()
        setupLocationManager()
        addGestures()
    }
    
    //MARK: - Lazy inits
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.showsUserLocation = true
        view.showsScale = true
        view.showsCompass = true
        view.showsBuildings = false
        view.showsPointsOfInterest = false
        view.delegate = self
        return view
    }()

    lazy var gameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.isEnabled = true
        button.setBackgroundImage(UIImage(named: "splashDash-icon"), for: .normal)
        button.addTarget(self, action: #selector(updateGameStatus), for: .touchUpInside)
        return button
    }()
    
    lazy var progressView: UIView = {
        //or stack view?
        let view = UIView()
        return view
    }()
}



