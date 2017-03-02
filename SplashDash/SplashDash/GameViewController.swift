//
//  GameViewController.swift
//  SplashDash
//
//  Created by Tong Lin on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import MapKit

class GameViewController: UIViewController {

    var locationManager: CLLocationManager!
    var lastLocation: CLLocationCoordinate2D!
    var gameStatus: Bool = false
    
    let color = [UIColor.red, UIColor.green, UIColor.blue, UIColor.cyan]
    var filCol: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewHierarchy()
        configureConstraints()
        setupLocationManager()
    }

    func setupViewHierarchy(){
        view.addSubview(mapView)
        view.addSubview(gameButton)
        
    }
    
    //MARK: - Lazy inits
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.alpha = 0.8
        view.showsUserLocation = true
        view.showsScale = true
        view.showsCompass = true
        view.showsBuildings = false
        view.delegate = self
        return view
    }()

    lazy var gameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .red
        button.isEnabled = true
        button.addTarget(self, action: #selector(updateGameStatus), for: .touchUpInside)
        return button
    }()
    
    lazy var progressView: UIView = {
        //or stack view?
        let view = UIView()
        return view
    }()
}



