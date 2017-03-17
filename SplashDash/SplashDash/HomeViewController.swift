//
//  HomeViewController.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/3/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import ScrollableSegmentedControl

import AVFoundation

class HomeViewController: UIViewController {
    //MARK: - Properties
    var tapGestureRecognizer: UITapGestureRecognizer!
    var segmentedControl: ScrollableSegmentedControl!
    var player: AVPlayer?
    
    var databaseReference: FIRDatabaseReference!
    var teamName: UserTeam!
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set up views
        setUpSegmentedControl()
        setUpViewHierarchy()
        setupPlayerLayer()
        
        databaseReference = FIRDatabase.database().reference()
        usernameTextField.isHidden = true
        stackview.isHidden = true
        stackview.delegate = self
        self.usernameTextField.alpha = 0
        segmentedControl.selectedSegmentIndex = 0
        configureConstraints()
        
        //Set up keyboard-resigning tap gesture
        setUpTapGesture()
        
        //Add Observer and Loop Video
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loopVideo),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.databaseReference.removeAllObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - AVPlayer Functions
    func setupPlayerLayer() {
        let videoURL: URL = Bundle.main.url(forResource: "Fresh-Paint", withExtension: "mp4")!
        
        player = AVPlayer(url: videoURL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        
        player?.play()
    }
    
    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    
    //MARK: - Set Up Views and Constraints
    func setUpViewHierarchy() {
        self.view.addSubview(filterView)
        self.view.addSubview(splashDashLogoImageView)
        self.view.addSubview(segmentedControl)
        self.view.addSubview(emailTextField)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signinRegisterButton)
        self.view.addSubview(hiddenLabel)
        self.view.addSubview(stackview)
    }
    
    func configureConstraints() {
        //filterview
        filterView.snp.makeConstraints { (view) in
            view.leading.trailing.top.bottom.equalTo(self.view)
        }
        
        //splashDashLogoImageView
        splashDashLogoImageView.snp.makeConstraints { (view) in
            view.width.equalTo(self.view.snp.width).multipliedBy(0.30)
            view.height.equalTo(self.view.snp.height).multipliedBy(0.165)
            view.centerX.equalTo(self.view.snp.centerX)
            view.top.equalTo(self.view.snp.top).offset(50)
        }
        
        //segmentedControl
        segmentedControl.snp.makeConstraints { (view) in
            view.top.equalTo(self.splashDashLogoImageView.snp.bottom).offset(40)
            view.height.equalTo(emailTextField.snp.height).multipliedBy(1.2)
            view.width.equalTo(self.emailTextField.snp.width).multipliedBy(0.93)
            view.centerX.equalToSuperview()
        }

        //emailTextField
        emailTextField.snp.makeConstraints { (view) in
            view.top.equalTo(segmentedControl.snp.bottom).offset(50)
            view.width.equalToSuperview().multipliedBy(0.765)
            view.centerX.equalToSuperview()
        }

        //usernameTextField
        usernameTextField.snp.makeConstraints { (view) in
            view.center.equalToSuperview()
            view.size.equalTo(CGSize(width: 1, height: 1))
        }

        //passwordTextField
        passwordTextField.snp.makeConstraints { (view) in
            view.top.equalTo(emailTextField.snp.bottom).offset(50)
            view.width.equalToSuperview().multipliedBy(0.765)
            view.centerX.equalToSuperview()
        }

        //signinRegisterButton
        signinRegisterButton.snp.makeConstraints { (view) in
            view.top.equalTo(passwordTextField.snp.bottom).offset(50)
            view.width.equalToSuperview().multipliedBy(0.6)
            view.centerX.equalToSuperview()
        }

        ///hiddenLabel
        hiddenLabel.snp.makeConstraints { (view) in
            view.top.equalTo(signinRegisterButton.snp.bottom).offset(8.0)
            view.width.equalToSuperview().multipliedBy(0.6)
            view.centerX.equalToSuperview()
        }

        //stackview
        stackview.snp.makeConstraints { (view) in
            view.center.equalToSuperview()
            view.size.equalTo(CGSize(width: 1, height: 1))
        }
        
    }
    
    func setUpSegmentedControl() {
        segmentedControl = ScrollableSegmentedControl()
        segmentedControl.segmentStyle = .textOnly
        segmentedControl.insertSegment(withTitle: "Sign in", at: 0)
        segmentedControl.insertSegment(withTitle: "Register", at: 1)
        
        segmentedControl.underlineSelected = true
        segmentedControl.addTarget(self, action: #selector(didSelect), for: .valueChanged)
        
        segmentedControl.tintColor = UIColor.lightGray
        
    }
    
    //MARK: - Segmented Control Helper Functions
    func didSelect() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segmentedControlWasSwitched(title: "Sign in")
            self.hiddenLabel.text = ""
            
            self.emailTextField.textLabel.textColor = .black
            self.emailTextField.textField.textColor = .black
            self.usernameTextField.textLabel.textColor = .black
            self.usernameTextField.textField.textColor = .black
            self.passwordTextField.textLabel.textColor = .black
            self.passwordTextField.textField.textColor = .black
            self.signinRegisterButton.backgroundColor = .lightGray
            self.signinRegisterButton.layer.borderColor = UIColor.lightGray.cgColor
            self.hiddenLabel.textColor = .lightGray
            
            self.stackview.tealImageView.removeShadows()
            self.stackview.orangeImageView.removeShadows()
            self.stackview.greenImageView.removeShadows()
            self.stackview.purpleImageView.removeShadows()
            
            self.teamName = nil
            
        default:
            segmentedControlWasSwitched(title: "Register")
            self.hiddenLabel.text = ""
        }
    }
    
    func segmentedControlWasSwitched(title: String){
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn, animations: nil)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            animator.addAnimations {
                self.emailTextField.snp.remakeConstraints { (view) in
                    view.top.equalTo(self.segmentedControl.snp.bottom).offset(50)
                    view.width.equalToSuperview().multipliedBy(0.765)
                    view.centerX.equalToSuperview()
                }
                
                self.usernameTextField.alpha = 0
                self.usernameTextField.isHidden = true
                self.usernameTextField.snp.remakeConstraints({ (view) in
                    view.center.equalToSuperview()
                    view.size.equalTo(CGSize(width: 1, height: 1))
                })
                
                self.passwordTextField.snp.remakeConstraints { (view) in
                    view.top.equalTo(self.emailTextField.snp.bottom).offset(50)
                    view.width.equalToSuperview().multipliedBy(0.765)
                    view.centerX.equalToSuperview()
                }
                
                self.stackview.isHidden = true
                self.stackview.snp.remakeConstraints { (view) in
                    view.center.equalToSuperview()
                    view.size.equalTo(CGSize(width: 1, height: 1))
                }
                
                self.signinRegisterButton.snp.remakeConstraints { (view) in
                    view.top.equalTo(self.passwordTextField.snp.bottom).offset(50)
                    view.width.equalToSuperview().multipliedBy(0.6)
                    view.centerX.equalToSuperview()
                }
                
                self.passwordTextField.textField.text = nil
                
                self.view.layoutIfNeeded()
            }
        }
        else {
            animator.addAnimations {
                self.emailTextField.snp.remakeConstraints { (view) in
                    view.top.equalTo(self.segmentedControl.snp.bottom).offset(40)
                    view.width.equalToSuperview().multipliedBy(0.765)
                    view.centerX.equalToSuperview()
                }
                
                self.usernameTextField.isHidden = false
                self.usernameTextField.setNeedsDisplay()
                self.usernameTextField.snp.remakeConstraints({ (view) in
                    view.top.equalTo(self.emailTextField.snp.bottom).offset(40)
                    view.width.equalToSuperview().multipliedBy(0.765)
                    view.centerX.equalToSuperview()
                })
                self.usernameTextField.alpha = 1.0
                
                self.passwordTextField.snp.remakeConstraints { (view) in
                    view.top.equalTo(self.usernameTextField.snp.bottom).offset(40)
                    view.width.equalToSuperview().multipliedBy(0.765)
                    view.centerX.equalToSuperview()
                }
                
                self.stackview.isHidden = false
                self.stackview.snp.remakeConstraints({ (view) in
                    view.top.equalTo(self.passwordTextField.snp.bottom).offset(40)
                    view.height.equalTo(30)
                    view.width.equalToSuperview().multipliedBy(0.8)
                    view.centerX.equalToSuperview()
                })
                
                self.signinRegisterButton.snp.remakeConstraints({ (view) in
                    view.top.equalTo(self.stackview.snp.bottom).offset(40)
                    view.width.equalToSuperview().multipliedBy(0.6)
                    view.centerX.equalToSuperview()
                })
                
//                self.emailTextField.textField.text = ""
//                self.usernameTextField.textField.text = ""
                self.passwordTextField.textField.text = nil
                
                self.view.layoutIfNeeded()
            }
        }
        
        animator.addCompletion { (position) in
            self.signinRegisterButton.setTitle(title, for: .normal)
        }
        
        animator.startAnimation()
    }
    
    //MARK: - Tap Gesture Method
    func setUpTapGesture() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureDismissKeyboard(_:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func tapGestureDismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //MARK: - Firebase Authentication
    func signinRegisterButtonPressed() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            signinButtonPressed()
            self.hiddenLabel.text = ""
        default:
            registerButtonPressed()
            self.hiddenLabel.text = ""
        }
    }
    
    func registerButtonPressed() {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.signinRegisterButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.signinRegisterButton.transform = CGAffineTransform.identity
                        }
                        
                        guard let email = self.emailTextField.textField.text,
                            let username = self.usernameTextField.textField.text,
                            let password = self.passwordTextField.textField.text,
                            let team = self.teamName,
                            email != "",
                            password != "" else {
                                self.hiddenLabel.text = "Please verify all fields have been entered and a team selected."
                                self.hiddenLabel.isHidden = false
                                return
                        }
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                            if error != nil {
                                self.hiddenLabel.text = error?.localizedDescription
                                self.hiddenLabel.isHidden = false
                                return
                            }
                            
                            guard let uid = user?.uid else { return }
                            let newUser = User(email: email, username: username, uid: uid, teamName: team, runs: [])
                            self.addUserToDatabase(newUser: newUser)
                            
                            //Sabrina's set up for team colors
                            let defaults = UserDefaults()
                            defaults.set(newUser.teamName.rawValue, forKey: "teamName")
                            
                            self.player?.pause()
                            self.present(GameViewController(), animated: true, completion: nil)
                        })
        })
    }
    
    func signinButtonPressed() {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.signinRegisterButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.signinRegisterButton.transform = CGAffineTransform.identity
                        }
                        
                        //Sign in via Firebase
                        guard let email = self.emailTextField.textField.text,
                            let password = self.passwordTextField.textField.text,
                            email != "",
                            password != "" else {
                                self.hiddenLabel.text = "Please verify all fields have been entered and a team selected."
                                self.hiddenLabel.isHidden = false
                                return
                        }
                        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                            if error != nil {
                                self.hiddenLabel.text = error?.localizedDescription
                                self.hiddenLabel.isHidden = false
                                return
                            }
                            print("User ID: \(user?.uid)")
                            
                            guard let uid = user?.uid else { return }
                            self.databaseReference = FIRDatabase.database().reference().child("Users").child(uid)
                            
                            self.databaseReference.observeSingleEvent(of: .value, with: { (snapshot) in
                                if let value = snapshot.value as? NSDictionary{
                                    if let user = User(value){
                                        let defaults = UserDefaults()
                                        defaults.set(user.teamName.rawValue, forKey: "teamName")
                                        let gameVC = GameViewController()
                                        self.player?.pause()
                                        self.present(gameVC, animated: true, completion: nil)
                                    }
                                }
                            })

                        })
        })
    }
    
    func addUserToDatabase(newUser: User){
        self.databaseReference = databaseReference.child("Users").child(newUser.uid)
        let data = newUser.toData()
        databaseReference.setValue(data)
    }
    
    //MARK: - Lazy Instantiation
    lazy var splashDashLogoImageView: UIImageView = {
        let image = UIImage(named: "splashDash-icon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var usernameTextField: SplashDashTextField = {
        let textField = SplashDashTextField(placeHolderText: "Username")
        
        return textField
    }()
    
    lazy var emailTextField: SplashDashTextField = {
        let textField = SplashDashTextField(placeHolderText: "Email")
        textField.textField.keyboardType = .emailAddress
        
        return textField
    }()
    
    lazy var passwordTextField: SplashDashTextField = {
        let textField = SplashDashTextField(placeHolderText: "Password")
        textField.textField.isSecureTextEntry = true
        
        return textField
    }()
    
    lazy var signinRegisterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.lightGray
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Sign in", for: .normal)
        button.layer.borderWidth = 2.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        button.addShadows()
        button.addTarget(self, action: #selector(signinRegisterButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    lazy var hiddenLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = .lightGray
        
        return label
    }()
    
    lazy var stackview: TeamStackView = {
        let view = TeamStackView()
        
        return view
    }()
    
    lazy var filterView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.3
        
        return view
    }()
}
