//
//  HomeViewController.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/3/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    //MARK: - Properties
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = SplashColor.primaryColor()
        
        //set up views
        setUpViewHierarchy()
        emailTextField.isHidden = true
        configureConstraints()
        
        //set up keyboard-resigning tap gesture
        setUpTapGesture()
    }
    
    func setUpViewHierarchy() {
        self.view.addSubview(containerView)
        self.view.addSubview(logoContainerView)
        self.view.addSubview(splashDashLogoImageView)
        self.view.addSubview(segmentedControl)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(emailTextField)
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
            view.width.equalTo(containerView.snp.width).multipliedBy(0.8)
            view.centerX.equalToSuperview()
        }
        
        //usernameTextField
        usernameTextField.snp.makeConstraints { (view) in
            view.top.equalTo(segmentedControl.snp.bottom).offset(20)
            view.width.equalTo(containerView.snp.width).multipliedBy(0.8)
            view.centerX.equalToSuperview()
        }
        
        //emailTextField
        emailTextField.snp.makeConstraints { (view) in
            view.center.equalToSuperview()
            view.size.equalTo(CGSize(width: 1, height: 1))
        }
        
        //passwordTextField
        passwordTextField.snp.makeConstraints { (view) in
            view.top.equalTo(usernameTextField.snp.bottom).offset(20)
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
    
    func switchForm(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            registerNewUser(type: "Log in")
        default:
            registerNewUser(type: "Register")
        }
    }
    
    func registerNewUser(type: String){
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn, animations: nil)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            animator.addAnimations {
                self.containerView.snp.remakeConstraints { (view) in
                    view.centerX.equalToSuperview()
                    view.centerY.equalToSuperview().offset(10)
                    view.height.equalToSuperview().multipliedBy(0.48)
                    view.width.equalToSuperview().multipliedBy(0.8)
                }
                
                self.emailTextField.isHidden = true
                self.emailTextField.snp.remakeConstraints({ (view) in
                    view.center.equalToSuperview()
                    view.size.equalTo(CGSize(width: 1, height: 1))
                })
                
                self.passwordTextField.snp.remakeConstraints { (view) in
                    view.top.equalTo(self.usernameTextField.snp.bottom).offset(20)
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
                
                self.emailTextField.isHidden = false
                self.emailTextField.setNeedsDisplay()
                self.emailTextField.snp.remakeConstraints({ (view) in
                    view.top.equalTo(self.usernameTextField.snp.bottom).offset(20)
                    view.width.equalTo(self.containerView.snp.width).multipliedBy(0.8)
                    view.centerX.equalToSuperview()
                })
                
                self.passwordTextField.snp.remakeConstraints { (view) in
                    view.top.equalTo(self.emailTextField.snp.bottom).offset(20)
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
            self.loginRegisterButton.setTitle(type, for: .normal)
        }
        
        animator.startAnimation()
    }
    
    //MARK: - Tap Gesture Methods
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
    
    lazy var segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl()
        view.insertSegment(withTitle: "Log in", at: 0, animated: true)
        view.insertSegment(withTitle: "Register", at: 1, animated: true)
        view.tintColor = SplashColor.primaryColor()
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(switchForm), for: .valueChanged)
        return view
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
        //button.addTarget(self, action: #selector(), for: .touchUpInside)
        
        return button
    }()
    
    lazy var hiddenLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = SplashColor.primaryColor()
        label.text = "HELLO WORLD"
        
        return label
    }()
}
