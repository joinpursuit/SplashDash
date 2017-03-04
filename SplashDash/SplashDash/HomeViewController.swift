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
import ISHPullUp
import TwicketSegmentedControl

class HomeViewController: UIViewController, TwicketSegmentedControlDelegate {
    //MARK: - Properties
    var tapGestureRecognizer: UITapGestureRecognizer!
    var segmentedControl: TwicketSegmentedControl!
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = SplashColor.primaryColor()
        
        //set up views
        setUpTwicketSegmentedControl()
        setUpViewHierarchy()
        
        usernameTextField.isHidden = true
        configureConstraints()
        
        //set up keyboard-resigning tap gesture
        setUpTapGesture()
    }
    
    //MARK: - Set Up Views and Constraints
    func setUpViewHierarchy() {
        self.view.addSubview(containerView)
        self.view.addSubview(logoContainerView)
        self.view.addSubview(splashDashLogoImageView)
        self.view.addSubview(segmentedControl)
        self.view.addSubview(emailTextField)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginRegisterButton)
        self.view.addSubview(hiddenLabel)
    }
    
    func configureConstraints() {
        //containerView
        containerView.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.centerY.equalToSuperview().offset(10)
            view.height.equalToSuperview().multipliedBy(0.48)
            view.width.equalToSuperview().multipliedBy(0.8)
        }
        
        //logoContainerview
        logoContainerView.snp.makeConstraints { (view) in
            view.size.equalTo(CGSize(width: 150, height: 150))
            view.centerX.equalToSuperview()
            view.centerY.equalTo(containerView.snp.top)
            
        }
        
        //splashDashLogoImageView
        splashDashLogoImageView.snp.makeConstraints { (view) in
            view.size.equalTo(CGSize(width: 110, height: 110))
            view.centerX.equalTo(logoContainerView.snp.centerX)
            view.centerY.equalTo(logoContainerView.snp.centerY)
        }
        
        //segmentedControl
        segmentedControl.snp.makeConstraints { (view) in
            view.top.equalTo(logoContainerView.snp.bottom).offset(15)
            view.height.equalTo(emailTextField.snp.height)
            view.width.equalTo(containerView.snp.width).multipliedBy(0.8)
            view.centerX.equalToSuperview()
        }
        
        //emailTextField
        emailTextField.snp.makeConstraints { (view) in
            view.top.equalTo(segmentedControl.snp.bottom).offset(20)
            view.width.equalTo(containerView.snp.width).multipliedBy(0.8)
            view.centerX.equalToSuperview()
        }
        
        //usernameTextField
        usernameTextField.snp.makeConstraints { (view) in
            view.center.equalToSuperview()
            view.size.equalTo(CGSize(width: 1, height: 1))
        }
        
        //passwordTextField
        passwordTextField.snp.makeConstraints { (view) in
            view.top.equalTo(emailTextField.snp.bottom).offset(20)
            view.width.equalTo(containerView.snp.width).multipliedBy(0.8)
            view.centerX.equalToSuperview()
        }
        
        //loginRegisterButton
        loginRegisterButton.snp.makeConstraints { (view) in
            view.top.equalTo(passwordTextField.snp.bottom).offset(25)
            view.width.equalToSuperview().multipliedBy(0.6)
            view.centerX.equalToSuperview()
        }
        
        ///hiddenLabel
        hiddenLabel.snp.makeConstraints { (view) in
            view.top.equalTo(loginRegisterButton.snp.bottom).offset(8.0)
            view.width.equalToSuperview().multipliedBy(0.6)
            view.centerX.equalToSuperview()
        }
        
    }
    
    func setUpTwicketSegmentedControl() {
        segmentedControl = TwicketSegmentedControl()
        segmentedControl.setSegmentItems(["Log in", "Register"])
        
        //Use color manager to determine color scheme here
        segmentedControl.layer.backgroundColor = SplashColor.lightPrimaryColor().cgColor
        segmentedControl.sliderBackgroundColor = SplashColor.primaryColor()
        segmentedControl.highlightTextColor = SplashColor.lightPrimaryColor()
        segmentedControl.defaultTextColor = SplashColor.darkPrimaryColor()
        segmentedControl.delegate = self
    }
    
    //MARK: - Segmented Control Helper Functions
    func didSelect(_ segmentIndex: Int) {
        switch segmentIndex {
        case 0:
            segmentedControlWasSwitched(title: "Log in")
            self.hiddenLabel.text = ""
        default:
            segmentedControlWasSwitched(title: "Register")
            self.hiddenLabel.text = ""
        }
    }
    
    func segmentedControlWasSwitched(title: String){
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn, animations: nil)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            animator.addAnimations {
                self.containerView.snp.remakeConstraints { (view) in
                    view.centerX.equalToSuperview()
                    view.centerY.equalToSuperview().offset(10)
                    view.height.equalToSuperview().multipliedBy(0.48)
                    view.width.equalToSuperview().multipliedBy(0.8)
                }
                
                self.usernameTextField.isHidden = true
                self.usernameTextField.snp.remakeConstraints({ (view) in
                    view.center.equalToSuperview()
                    view.size.equalTo(CGSize(width: 1, height: 1))
                })
                
                self.passwordTextField.snp.remakeConstraints { (view) in
                    view.top.equalTo(self.emailTextField.snp.bottom).offset(20)
                    view.width.equalTo(self.containerView.snp.width).multipliedBy(0.8)
                    view.centerX.equalToSuperview()
                }
                
                self.view.layoutIfNeeded()
            }
        }
        else {
            animator.addAnimations {
                self.containerView.snp.remakeConstraints({ (view) in
                    view.centerX.equalToSuperview()
                    view.centerY.equalToSuperview().offset(10)
                    view.height.equalToSuperview().multipliedBy(0.55)
                    view.width.equalToSuperview().multipliedBy(0.8)
                })
                
                self.usernameTextField.isHidden = false
                self.usernameTextField.setNeedsDisplay()
                self.usernameTextField.snp.remakeConstraints({ (view) in
                    view.top.equalTo(self.emailTextField.snp.bottom).offset(20)
                    view.width.equalTo(self.containerView.snp.width).multipliedBy(0.8)
                    view.centerX.equalToSuperview()
                })
                
                self.passwordTextField.snp.remakeConstraints { (view) in
                    view.top.equalTo(self.usernameTextField.snp.bottom).offset(20)
                    view.width.equalTo(self.containerView.snp.width).multipliedBy(0.8)
                    view.centerX.equalToSuperview()
                }
                
                self.emailTextField.textField.text = ""
                self.usernameTextField.textField.text = ""
                self.passwordTextField.textField.text = ""
                
                self.view.layoutIfNeeded()
            }
        }
        
        animator.addCompletion { (position) in
            self.loginRegisterButton.setTitle(title, for: .normal)
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
    func loginRegisterButtonPressed() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            loginButtonPressed()
            self.hiddenLabel.text = ""
        default:
            registerButtonPressed()
            self.hiddenLabel.text = ""
        }
    }
    
    func registerButtonPressed() {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.loginRegisterButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.loginRegisterButton.transform = CGAffineTransform.identity
                        }
                        
                        //WE ARE CURRENTLY NOT USING THE USERNAME FOR ANYTHING
                        
                        guard let email = self.emailTextField.textField.text,
                            let password = self.passwordTextField.textField.text,
                            email != "",
                            password != "" else {
                                self.hiddenLabel.text = "Please verify all fields have been entered."
                                self.hiddenLabel.isHidden = false
                                return
                        }
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                            if error != nil {
                                self.hiddenLabel.text = error?.localizedDescription
                                self.hiddenLabel.isHidden = false
                                return
                            }
                            
                            //create User object
                            print("User ID: \(user?.uid)")
                            print("Registered and logged in new user.")
                            
                            self.present(GameViewController(), animated: true, completion: nil)
                        })
        })
    }
    
    func loginButtonPressed() {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.loginRegisterButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.loginRegisterButton.transform = CGAffineTransform.identity
                        }
                        
                        //Login via Firebase
                        guard let email = self.emailTextField.textField.text,
                            let password = self.passwordTextField.textField.text,
                            email != "",
                            password != "" else {
                                self.hiddenLabel.text = "Please verify the format of your email and password."
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
                            
                            let gameVC = GameViewController()
                            let userInfoVC = UserInfoViewController()
                            let ishPullUpVC = ISHPullUpViewController()
                            ishPullUpVC.contentViewController = gameVC
                            ishPullUpVC.bottomViewController = userInfoVC
                            
                            self.present(ishPullUpVC, animated: true, completion: nil)
                        })
        })
    }
    
    //MARK: - Lazy Instantiation
    lazy var containerView: UIView = {
        let view = UIView()
        
        //Use color manager to change the backgroundColor to the color determined by Sabrina and design mentor.
        view.backgroundColor = SplashColor.lightPrimaryColor()
        view.layer.cornerRadius = 20
        view.addShadows()
        
        return view
    }()
    
    lazy var logoContainerView: UIView = {
        let view = UIView()
        
        //Use color manager to change the backgroundColor to the color determined by Sabrina and design mentor.
        view.backgroundColor = SplashColor.darkPrimaryColor()
        
        //size of logoContainerView is 150x150
        view.layer.cornerRadius = 75
        view.addShadows()
        
        return view
    }()
    
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
        
        return textField
    }()
    
    lazy var passwordTextField: SplashDashTextField = {
        let textField = SplashDashTextField(placeHolderText: "Password")
        textField.textField.isSecureTextEntry = true
        
        return textField
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = SplashColor.primaryColor()
        button.setTitleColor(SplashColor.lightPrimaryColor(), for: .normal)
        button.setTitle("Log in", for: .normal)
        button.layer.borderWidth = 2.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.borderColor = SplashColor.primaryColor().cgColor
        button.layer.cornerRadius = 10
        button.addShadows()
        button.addTarget(self, action: #selector(loginRegisterButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    lazy var hiddenLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = SplashColor.primaryColor()
        
        return label
    }()
}
