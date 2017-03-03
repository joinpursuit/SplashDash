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
    var historySplash: [SplashColor] = []
    var gameStatus: Bool = false
    var isButtonsOffScreen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewHierarchy()
        configureConstraints()
    }

    func setupViewHierarchy(){
        view.addSubview(mapView)
        view.addSubview(gameButton)
        view.addSubview(findMeButton)
        
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
    
    lazy var findMeButton: UIButton = {
        let button = UIButton(type: UIButtonType.contactAdd)
        button.isEnabled = true
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.width/2
        button.addTarget(self, action: #selector(toCurrentLocation), for: .touchUpInside)
        return button
    }()
}



