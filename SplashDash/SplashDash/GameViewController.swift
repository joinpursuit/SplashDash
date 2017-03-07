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
import ISHPullUp

class GameViewController: UIViewController, ISHPullUpContentDelegate {

    let databaseReference = FIRDatabase.database().reference()
    
    let dateFormatter = DateFormatter()
    
    var locationManager: CLLocationManager!
    var currentRun: [SplashCoordinate] = []
    var gameStatus: Bool = false
    var isButtonsOffScreen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewHierarchy()
        configureConstraints()
        setupLocationManager()
        addGestures()
        fetchGlobalSplash()
        mapView.preservesSuperviewLayoutMargins = true
        
        dateFormatter.dateFormat = "HH:mm:ss"
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats:true);
    }
    
    // MARK: ISHPullUpContentDelegate
    
    func pullUpViewController(_ vc: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forContentViewController _: UIViewController) {

        // update edgeInsets
        self.rootView.layoutMargins = edgeInsets
        
        // call layoutIfNeeded right away to participate in animations
        // this method may be called from within animation blocks
        self.rootView.layoutIfNeeded()
    }

    func setupViewHierarchy(){
        view.addSubview(rootView)
        self.rootView.addSubview(mapView)
        self.rootView.addSubview(gameButton)
        self.rootView.addSubview(findMeButton)
        self.rootView.addSubview(countDownLabel)
    }
    
    //MARK: - Lazy inits
    lazy var rootView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
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
        let originalSplash = UIImage(named: "logoSplash")
        let colorableSplash = originalSplash?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(colorableSplash, for: .normal)
        button.tintColor = .blue // placeholder color
        button.addShadows()
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(updateGameStatus), for: .touchUpInside)
        return button
    }()
    
    lazy var findMeButton: UIButton = {
        let button = UIButton(type: UIButtonType.contactAdd)
        button.isEnabled = true
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 35
        button.addShadows()
        button.addTarget(self, action: #selector(toCurrentLocation), for: .touchUpInside)
        return button
    }()
    
    lazy var countDownLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20)
        return view
    }()
}



