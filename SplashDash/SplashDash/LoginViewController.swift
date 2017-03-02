//
//  LoginViewController.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    //MARK: - Properties
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewHierarchy()
        configureConstraints()
        
        //Use color manager to change the backgroundColor to the color determined by Sabrina and design mentor.
        view.backgroundColor = .red
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpViewHierarchy() {
        self.view.addSubview(containerView)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(splashDashLogoImageView)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
    }
    
    func configureConstraints() {
        //containerView
        containerView.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(self.view.snp.top).offset(130.0)
            view.height.equalTo(300)
            view.width.equalTo(250)
        }
        
        //splashDashLogoImageView
        splashDashLogoImageView.snp.makeConstraints { (view) in
            view.height.equalTo(150)
            view.width.equalTo(150)
            view.top.equalTo(containerView.snp.top).offset(20.0)
            view.centerX.equalTo(containerView.snp.centerX)
        }

        //usernameTextField
        usernameTextField.snp.makeConstraints { (view) in
            view.top.equalTo(splashDashLogoImageView.snp.bottom).offset(16.0)
            view.leading.equalTo(containerView.snp.leading).offset(25.0)
            view.trailing.equalTo(containerView.snp.trailing).inset(25.0)
        }
        
        //passwordTextField
        passwordTextField.snp.makeConstraints({ (view) in
            view.top.equalTo(usernameTextField.snp.bottom).offset(16.0)
            view.leading.equalTo(containerView.snp.leading).offset(25.0)
            view.trailing.equalTo(containerView.snp.trailing).inset(25.0)
        })
        
        //loginButton
        loginButton.snp.makeConstraints { (view) in
            view.height.equalTo(30.0)
            view.width.equalTo(containerView.snp.width)
            view.centerX.equalToSuperview()
            view.top.equalTo(containerView.snp.bottom).offset(16.0)
        }
        
        //registerButton
        registerButton.snp.makeConstraints { (view) in
            view.top.equalTo(loginButton.snp.bottom).offset(16.0)
            view.height.equalTo(30.0)
            view.width.equalTo(containerView.snp.width)
            view.centerX.equalToSuperview()
            //view.bottom.equalTo(self.view.snp.bottom).inset(16.0)
        }
    }
    
    //MARK: - Lazy instantiation
    lazy var containerView: UIView = {
        let view = UIView()
        
        //Use color manager to change the backgroundColor to the color determined by Sabrina and design mentor.
        view.backgroundColor = UIColor.yellow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.font = UIFont.systemFont(ofSize: 12.0)
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .bezel
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.8
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 2
        
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 12.0)
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .bezel
        textField.isSecureTextEntry = true
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.8
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 2
        
        return textField
    }()
    
    lazy var splashDashLogoImageView: UIImageView = {
        
        //image needs to be replaced with the digital version of our logo
        let image = UIImage(named: "splashDash-icon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 2
        
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 2
        
        return button
    }()
    
}

