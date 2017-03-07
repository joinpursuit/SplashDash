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
        
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats:true);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bottomRootView.clipsToBounds = true
    }
    
    // MARK: - Actions
    
    // 105 is an arbitrary number
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let topViewHeight = bottomView.topView.frame.height
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            // note: 'view' is optional and need to be unwrapped
            if gestureRecognizer.view!.center.y - gestureRecognizer.view!.frame.height/2 < topViewHeight {
                
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: topViewHeight + gestureRecognizer.view!.frame.height/2)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                
                return }
            
            if gestureRecognizer.view!.center.y - gestureRecognizer.view!.frame.height/2 > self.view.frame.height - topViewHeight {
                
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: self.view.frame.height + gestureRecognizer.view!.frame.height/2 - topViewHeight)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                
                return
            }
            
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
    }

    // MARK: - Setup
    
    func setupViewHierarchy(){

        self.view.addSubview(mapView)
        self.view.addSubview(bottomRootView)
        self.bottomRootView.addSubview(bottomView)
        self.view.addSubview(gameButton)
        self.view.addSubview(findMeButton)
        self.view.addSubview(countDownLabel)
    }
    
    func configureConstraints(){
        mapView.snp.remakeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
        
        
        bottomRootView.snp.remakeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            
            // TO DO: calculate offsets to topView.height
            view.height.equalToSuperview().offset(-30)
            view.top.equalTo(self.view.snp.bottom).inset(100.0)
//            print("bottomView.topView.frame.height \(bottomView.topView.frame.height)")
//            view.top.equalTo(self.view.snp.bottom).inset(bottomView.topView.frame.height)
        }
        
        bottomView.snp.remakeConstraints { (view) in
            view.leading.top.trailing.bottom.equalToSuperview()
        }
        
        gameButton.snp.remakeConstraints { (view) in
            // view.bottom.equalTo(bottomRootView.snp.top).offset(-30)
            view.centerY.equalTo(bottomRootView.snp.top)
            view.trailing.equalToSuperview().offset(-30)
            view.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        findMeButton.snp.remakeConstraints { (view) in
            view.trailing.equalTo(gameButton)
            view.bottom.equalTo(gameButton.snp.top).offset(-40)
            view.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        countDownLabel.snp.remakeConstraints { (view) in
            view.top.equalToSuperview().offset(40)
            view.trailing.equalToSuperview().offset(-30)
            
        }
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
    
    lazy var countDownLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20)
        return view
    }()
    
    lazy var bottomRootView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.95
        view.layer.cornerRadius = 10.0
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(gestureRecognizer)
        return view
    }()
    
    lazy var bottomView: BottomView = {
        let view = BottomView()
        return view
    }()
}
