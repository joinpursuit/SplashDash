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
    
    let databaseReference = FIRDatabase.database().reference().child("Public")
    var locationManager: CLLocationManager!
    var currentRun: Run = Run(allCoordinates: [])
    var endGame: Bool = false
    var gameStatus: Bool = false
    var isButtonsOffScreen: Bool = false
    var bottomViewPreviousPosition: CGFloat = 0.0
    
    var mySwitch = true
    var allLabel: [UILabel] = []
    
    var currentUser: User? {
        didSet {
            // This should be refactored into registration/login 
            let defaults = UserDefaults()
            if let user = currentUser {
                defaults.set(user.teamName.rawValue, forKey: "teamName")
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrentUserData()
        setupViewHierarchy()
        configureConstraints()
        setupLocationManager()
        updateLabel()
        fetchGlobalSplash()
//        mapView.preservesSuperviewLayoutMargins = true
        
//        let displaylink = CADisplayLink(target: self, selector: #selector(updateLabel))
//        displaylink.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats:true);
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bottomCorneredContainerView.clipsToBounds = true

    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        print("self.view.frame.height is \(self.view.frame.height)")
//        print("self.bottomCorneredContainerView.frame.height is \(self.bottomCorneredContainerView.frame.height)")
//        print("---The difference is \(self.view.frame.height - self.bottomCorneredContainerView.frame.height)---")
//        print("self.bottomRootView.frame.height is \(self.bottomRootView.frame.height)")
//        print()
//    }
    
    // MARK: - Setup
    
    func setupViewHierarchy(){

        self.view.addSubview(mapView)
        self.mapView.addSubview(findMeButton)
        self.mapView.addSubview(endGameButton)

//        self.mapView.addSubview(bottomRootView)
        self.view.addSubview(bottomRootView)

        self.bottomRootView.addSubview(bottomCorneredContainerView)
        self.bottomCorneredContainerView.addSubview(bottomView)
        self.bottomRootView.addSubview(gameButton)
        
        self.view.addSubview(displayView)
        self.view.addSubview(gameReadyLabel)
    }
    
    func configureConstraints(){
        mapView.snp.remakeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
        
        bottomRootView.snp.remakeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
//          This extension of bottomRootView allows all buttons to be selectable
            view.top.equalTo(self.gameButton.snp.top)
            view.bottom.equalTo(bottomCorneredContainerView.snp.bottom)
        }
        
        bottomCorneredContainerView.snp.remakeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            view.top.equalTo(self.view.snp.bottom).inset(bottomView.topViewSpacing)
            view.height.equalTo(self.view.snp.height).offset(-bottomView.topViewSpacing)
        }
        
        bottomView.snp.remakeConstraints { (view) in
            view.leading.top.trailing.bottom.equalToSuperview()
        }
        
        gameButton.snp.remakeConstraints { (view) in
            view.centerY.equalTo(bottomCorneredContainerView.snp.top)
            view.trailing.equalToSuperview().offset(-30)
            view.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        findMeButton.snp.remakeConstraints { (view) in
            view.trailing.equalTo(gameButton)
            view.bottom.equalTo(gameButton.snp.top).offset(-40)
            view.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        endGameButton.snp.remakeConstraints { (view) in
            view.centerX.equalTo(findMeButton)
            view.bottom.equalTo(findMeButton.snp.top).offset(-30)
            view.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        displayView.snp.remakeConstraints { (view) in
            view.leading.trailing.centerY.equalToSuperview()
            view.height.equalTo(200)
        }
        
        gameReadyLabel.snp.remakeConstraints { (view) in
            view.center.equalToSuperview()
            view.width.equalTo(1000)
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedOnMap(sender:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()

    lazy var gameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = true
        let originalSplash = UIImage(named: "logoSplash")
        let colorableSplash = originalSplash?.withRenderingMode(.alwaysTemplate).imageWithColor(color1: SplashColor.primaryColor())
        button.setBackgroundImage(colorableSplash, for: .normal)
        button.addShadows()
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var findMeButton: UIButton = {
        let button = UIButton(type: UIButtonType.contactAdd)
        button.isEnabled = true
        button.backgroundColor = SplashColor.primaryColor()
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.tintColor = .white
        button.addShadows()
        button.addTarget(self, action: #selector(toCurrentLocation), for: .touchUpInside)
        return button
    }()
    
    lazy var endGameButton: UIButton = {
        let button = UIButton(type: UIButtonType.infoLight)
        button.isEnabled = true
        button.backgroundColor = SplashColor.primaryColor()
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.tintColor = .white
        button.addShadows()
        button.addTarget(self, action: #selector(endGameScreenshot), for: .touchUpInside)
        return button
    }()
    
    lazy var displayView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.4
        return view
    }()
    
    lazy var gameReadyLabel: UILabel = {
        let view = UILabel()
        view.text = "READY"
        view.font = UIFont.boldSystemFont(ofSize: 40)
        view.tintColor = .red
        view.textAlignment = .natural
        return view
    }()
    
    lazy var bottomRootView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
//        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        view.addGestureRecognizer(gestureRecognizer)


        return view
    }()
    
    lazy var bottomCorneredContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 7.0
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(gestureRecognizer)
        
        return view
    }()
    
    lazy var bottomView: BottomView = {
        let view = BottomView()
                view.isUserInteractionEnabled = true
        return view
    }()
}
