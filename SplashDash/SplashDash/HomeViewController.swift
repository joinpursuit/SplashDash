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
        configureConstraints()
        setUpTapGesture()
    }
    
    func setUpViewHierarchy() {
        self.view.addSubview(containerView)
        self.view.addSubview(logoContainerView)
        self.view.addSubview(splashDashLogoImageView)
        self.view.addSubview(segmentedControl)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
    }
    
    func configureConstraints() {
        //containerView
        containerView.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.centerY.equalToSuperview().offset(10)
            view.height.equalToSuperview().multipliedBy(0.55)
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
        
        //passwordTextField
        passwordTextField.snp.makeConstraints { (view) in
            view.top.equalTo(usernameTextField.snp.bottom).offset(20)
            view.width.equalTo(containerView.snp.width).multipliedBy(0.8)
            view.centerX.equalToSuperview()
        }
        
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
        view.tintColor = SplashColor.darkPrimaryColor()
        view.selectedSegmentIndex = 0
        //view.addTarget(self, action: #selector(switchForm), for: .valueChanged)
        return view
    }()
    
    lazy var usernameTextField: SplashDashTextField = {
        let textField = SplashDashTextField(placeHolderText: "Username")
        
        return textField
    }()
    
    lazy var passwordTextField: SplashDashTextField = {
        let textField = SplashDashTextField(placeHolderText: "Password")
        
        return textField
    }()
}


//func switchForm(sender: UISegmentedControl){
//    switch sender.selectedSegmentIndex{
//    case 0:
//        registerNewUser(type: "Log in")
//    default:
//        registerNewUser(type: "Register")
//    }
//}

//func registerNewUser(type: String){
//    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn, animations: nil)
//    
//    if modeSwitch.selectedSegmentIndex == 0{
//        animator.addAnimations {
//            self.nameTextField.isHidden = true
//            self.nameTextField.snp.remakeConstraints({ (view) in
//                view.center.equalToSuperview()
//                view.size.equalTo(CGSize(width: 1, height: 1))
//            })
//            
//            self.passwordTextField.snp.remakeConstraints { (view) in
//                view.top.equalTo(self.emailTextField.snp.bottom).offset(15)
//                view.width.equalToSuperview().multipliedBy(0.8)
//                view.centerX.equalToSuperview()
//            }
//            
//            self.containerView.layoutIfNeeded()
//        }
//    }else{
//        animator.addAnimations {
//            self.nameTextField.isHidden = false
//            self.nameTextField.snp.remakeConstraints({ (view) in
//                view.top.equalTo(self.emailTextField.snp.bottom).offset(15)
//                view.width.equalToSuperview().multipliedBy(0.8)
//                view.centerX.equalToSuperview()
//            })
//            
//            self.passwordTextField.snp.remakeConstraints { (view) in
//                view.top.equalTo(self.nameTextField.snp.bottom).offset(15)
//                view.width.equalToSuperview().multipliedBy(0.8)
//                view.centerX.equalToSuperview()
//            }
//            
//            self.emailTextField.text = ""
//            self.nameTextField.text = ""
//            self.passwordTextField.text = ""
//            
//            self.containerView.layoutIfNeeded()
//        }
//    }
//    
//    animator.addCompletion { (position) in
//        self.logAndRegButton.setTitle(type, for: .normal)
//    }
//    
//    animator.startAnimation()
//}
