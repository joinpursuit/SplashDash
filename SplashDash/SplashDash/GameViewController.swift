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
//import ISHPullUp

class GameViewController: UIViewController {
    
    let databaseReference = FIRDatabase.database().reference()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        self.bottomView.layer.cornerRadius = 10.0
        self.bottomRootView.clipsToBounds = true
    }
    
    // MARK: - Actions
    
    // 105 is an arbitrary number
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            // note: 'view' is optional and need to be unwrapped
            if gestureRecognizer.view!.center.y - gestureRecognizer.view!.frame.height/2 < 105 {
                
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: 105 + gestureRecognizer.view!.frame.height/2)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                
                return }
            
            if gestureRecognizer.view!.center.y - gestureRecognizer.view!.frame.height/2 > self.view.frame.height - 105 {
                
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: self.view.frame.height + gestureRecognizer.view!.frame.height/2 - 105)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                
                return
            }
            
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
            
            //            print("----------")
            //            print("gestureRecognizer.view!.center.y:")
            //            dump(gestureRecognizer.view!.center.y)
            //            print("translation.y:")
            //            dump(translation.y)
            //            print("gestureRecognizer.view!.center:")
            //            dump(gestureRecognizer.view!.center)
            //            print("----------")
        }
    }

    func setupViewHierarchy(){
        self.view.addSubview(mapView)
        self.view.addSubview(gameButton)
        self.view.addSubview(findMeButton)
        self.view.addSubview(bottomRootView)
        self.bottomRootView.addSubview(bottomView)
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
        let originalSplash = UIImage(named: "logoSplash")
        let colorableSplash = originalSplash?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(colorableSplash, for: .normal)
        button.tintColor = .blue // placeholder color
        button.addShadows()
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
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
    
    lazy var bottomRootView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.9
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(gestureRecognizer)
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    lazy var bottomView: BottomView = {
        let view = BottomView()
        return view
    }()
}
