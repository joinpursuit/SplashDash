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
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    let databaseReference = FIRDatabase.database().reference().child("Public")
    var locationManager: CLLocationManager!
    var currentRunCoordinates: [SplashCoordinate] = []
    var gameStatus: Bool = false
    var isButtonsOffScreen: Bool = false
    var bottomViewPreviousPosition: CGFloat = 0.0
    var timer: Timer?
    
    var scene: SplashScene!
    var mySwitch = true
    var allLabel: [UILabel] = []
    
    var currentUser: User? {
        didSet {
            // This should be refactored into registration/login 
            let defaults = UserDefaults()
            if let user = currentUser {
                defaults.set(user.teamName.rawValue, forKey: "teamName")
                bottomView.contentCollectionView.userRunHistoryView.user = user
            }
        }
    }
    
    var bottomViewIsUp = false {
        didSet {
            if bottomViewIsUp {
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                    self.bringUpBottomView()
                    self.view.layoutIfNeeded()
                }, completion: nil)
                self.displayView.isHidden = false
                if !isButtonsOffScreen {
                    animateAllButtons()
                }
            } else {
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                    self.configureBottomView()
                    self.view.layoutIfNeeded()
                }, completion: nil)
                self.displayView.isHidden = true
                if isButtonsOffScreen {
                    animateAllButtons()
                }
            }
        }
    }
    
    // To calculate total distance
    var previousLocation:CLLocation!
    var traveledDistanceInMeters:Double = 0 {
        didSet {
            guard traveledDistanceInMeters > 0 else {
                self.bottomView.distanceNumLabel.text = "0"
                return }
            // convert to miles
            let traveledDistanceInMiles = traveledDistanceInMeters * 0.000621371
            let distance = String.localizedStringWithFormat("%.2f", traveledDistanceInMiles)
            self.bottomView.distanceNumLabel.text = "\(distance) miles"
        }
    }
    
    // To calculate duration
    var duration = 0 {
        didSet {
            guard duration > 0 else {
                self.bottomView.durationNumLabel.text = "0"
                return }
            var durationString = ""
            let hours = duration / 3600
            let minutes = (duration % 3600) / 60
            let seconds = (duration % 3600) % 60
            
            if hours > 0 {
                durationString += "\(hours)h "
            }
            if minutes > 0 {
                durationString += "\(minutes)m "
            }
            durationString += "\(seconds)s"
            
            self.bottomView.durationNumLabel.text = durationString
        }
    }
    
    //Color count
    var currentScore: [(color: String, score: Double)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrentUserData()
        setupViewHierarchy()
        configureConstraints()
        setupLocationManager()
        updateLabel()
        fetchGlobalSplash()
        self.bottomView.contentCollectionView.preservesSuperviewLayoutMargins = true
        
        //add timer to calculate score every ten mins

//        Timer.scheduledTimer(timeInterval: 600, target: self, selector: #selector(takeScreenshot), userInfo: nil, repeats:true);
        
        //init a stickman off screen
        self.scene.stickmanInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bottomCorneredContainerView.clipsToBounds = true
        self.bottomView.contentCollectionView.mapHistoryView.mapSliderView.layer.cornerRadius = 5
        self.bottomView.contentCollectionView.mapHistoryView.mapSliderView.layer.masksToBounds = true
    }
    
    // MARK: - Setup
    func setupViewHierarchy(){
        
        self.view.addSubview(invisibleMapView)
        self.view.addSubview(mapView)
        self.mapView.addSubview(gameButton)
        self.mapView.addSubview(findMeButton)
        
        let skView = SplashSKView(frame: self.view.frame)
        skView.allowsTransparency = true
        
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        self.view.addSubview(displayView)

        self.view.addSubview(bottomCorneredContainerView)
        self.bottomCorneredContainerView.addSubview(bottomView)
        
        self.view.addSubview(skView)
        
        //Leaderboard views
        self.view.addSubview(firstPlaceView)
        self.view.addSubview(secondPlaceView)
        self.view.addSubview(thirdPlaceView)
        self.view.addSubview(fourthPlaceView)
        
        self.scene = SplashScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
    }
    
    func configureConstraints(){
        invisibleMapView.snp.remakeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
        
        mapView.snp.remakeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
        
        configureBottomView()
        
        // TO DELETE - BUTTON HERE FOR DEBUGGING
        findMeButton.snp.remakeConstraints { (view) in
            view.centerX.equalTo(gameButton.snp.centerX)
            view.bottom.equalTo(gameButton.snp.top).offset(-40)
            view.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        gameButton.snp.remakeConstraints { (view) in
            view.trailing.equalToSuperview().offset(-30)
//            view.bottom.equalToSuperview().offset(-bottomView.topView.frame.height - 30)
            view.bottom.equalToSuperview().offset(-130)
            view.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        firstPlaceView.snp.remakeConstraints { (view) in
            view.trailing.equalToSuperview().offset(20.0)
            view.top.equalToSuperview().offset(8.0)
            view.height.equalToSuperview().multipliedBy(0.06)
            view.leading.equalTo(self.view.snp.centerX).multipliedBy(1.05)
        }
        
        secondPlaceView.snp.remakeConstraints { (view) in
            view.top.equalTo(firstPlaceView.snp.bottom).offset(8.0)
            view.trailing.equalToSuperview().offset(20.0)
            view.height.equalToSuperview().multipliedBy(0.06)
            view.leading.equalTo(self.view.snp.centerX).multipliedBy(1.15)
        }
        
        thirdPlaceView.snp.remakeConstraints { (view) in
            view.top.equalTo(secondPlaceView.snp.bottom).offset(8.0)
            view.trailing.equalToSuperview().offset(20.0)
            view.height.equalToSuperview().multipliedBy(0.06)
            view.leading.equalTo(self.view.snp.centerX).multipliedBy(1.25)
        }
        
        fourthPlaceView.snp.remakeConstraints { (view) in
            view.top.equalTo(thirdPlaceView.snp.bottom).offset(8.0)
            view.trailing.equalToSuperview().offset(20.0)
            view.height.equalToSuperview().multipliedBy(0.06)
            view.leading.equalTo(self.view.snp.centerX).multipliedBy(1.35)
        }

        displayView.snp.remakeConstraints { (view) in
            view.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func configureBottomView() {
        bottomCorneredContainerView.snp.remakeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            view.top.equalTo(self.view.snp.bottom).inset(bottomView.topViewSpacing)
            view.height.equalTo(self.view.snp.height).offset(-bottomView.topViewSpacing)
        }
        
        bottomView.snp.remakeConstraints { (view) in
            view.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func bringUpBottomView() {
        bottomCorneredContainerView.snp.remakeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            view.top.equalTo(self.view.snp.top).inset(bottomView.topViewSpacing)
            view.height.equalTo(self.view.snp.height).offset(-bottomView.topViewSpacing)
        }
        
        bottomView.snp.remakeConstraints { (view) in
            view.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Lazy inits
    lazy var invisibleMapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.showsUserLocation = false
        view.showsScale = false
        view.showsCompass = false
        view.showsBuildings = false
        view.showsPointsOfInterest = false
        view.delegate = self
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
        button.layer.cornerRadius = 22
        button.tintColor = .white
        button.addShadows()
        button.alpha = 0.2
        button.addTarget(self, action: #selector(toCurrentLocation), for: .touchUpInside)
        return button
    }()
    
    lazy var displayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3
        view.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(displayViewTapped(sender:)))
        view.addGestureRecognizer(tapGestureRecognizer)
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
    
    lazy var firstPlaceView: LeaderboardView = {
        let view = LeaderboardView()
        view.layer.cornerRadius = 20.0

        view.rankingLabel.text = "1st"
        view.alpha = 0
        
        return view
    }()
    
    lazy var secondPlaceView: LeaderboardView = {
        let view = LeaderboardView()
        view.layer.cornerRadius = 20.0
        
        view.rankingLabel.text = "2nd"
        view.alpha = 0
        
        return view
    }()
    
    lazy var thirdPlaceView: LeaderboardView = {
        let view = LeaderboardView()
        view.layer.cornerRadius = 20.0
        
        view.rankingLabel.text = "3rd"
        view.alpha = 0
        
        return view
    }()
    
    lazy var fourthPlaceView: LeaderboardView = {
        let view = LeaderboardView()
        view.layer.cornerRadius = 20.0
        
        view.rankingLabel.text = "4th"
        view.alpha = 0
        
        return view
    }()
}
