//
//  RegisterViewController.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewHierarchy()
        configureConstraints()
        
        //Use color manager to change the backgroundColor to the color determined by Sabrina and design mentor.
        self.view.backgroundColor = SplashColor.primaryColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpViewHierarchy() {
        self.view.addSubview(containerView)
        self.view.addSubview(avatarImageView)
        self.view.addSubview(addProfilePicButton)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(detailLabel)
        self.view.addSubview(stackview)
        self.view.addSubview(registerButton)
    }
    
    func configureConstraints() {
        //containerView
        containerView.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(self.view.snp.top).offset(130.0)
            view.height.equalTo(350)
            view.width.equalTo(250)
        }
        
        //avatarImageView
        avatarImageView.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(containerView.snp.top).offset(8.0)
            view.width.equalTo(150.0)
            view.height.equalTo(150.0)
        }
        
        //addProfilePicButton
        addProfilePicButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(avatarImageView.snp.bottom).offset(8.0)
            //view.leading.equalTo(containerView.snp.leading).offset(25.0)
            //view.trailing.equalTo(containerView.snp.trailing).inset(25.0)
            view.width.equalTo(avatarImageView.snp.width)
            view.height.equalTo(20.0)
        }
        
        //usernameTextField
        usernameTextField.snp.makeConstraints { (view) in
            view.top.equalTo(addProfilePicButton.snp.bottom).offset(10.0)
            view.leading.equalTo(containerView.snp.leading).offset(25.0)
            view.trailing.equalTo(containerView.snp.trailing).inset(25.0)
        }
        
        //passwordTextField
        passwordTextField.snp.makeConstraints({ (view) in
            view.top.equalTo(usernameTextField.snp.bottom).offset(16.0)
            view.leading.equalTo(containerView.snp.leading).offset(25.0)
            view.trailing.equalTo(containerView.snp.trailing).inset(25.0)
        })
        
        //label
        detailLabel.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(passwordTextField.snp.bottom).offset(8.0)
        }
        
        //stackview
        stackview.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(detailLabel.snp.bottom).offset(8.0)
            view.bottom.equalTo(containerView.snp.bottom).inset(16.0)
            view.width.equalTo(avatarImageView.snp.width)
        }
        
        //registerButton
        registerButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(containerView.snp.bottom).offset(16.0)
            view.width.equalTo(containerView.snp.width)
        }
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
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.addShadows()
        
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.addShadows()
        
        return textField
    }()
    
    lazy var avatarImageView: UIImageView = {
        
        //replace this image with a better looking placeholder
//        let image = UIImage(named: "user-icon")
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1.0
        
        return imageView
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "Select a team:"
        
        return label
    }()
    
    lazy var addProfilePicButton: UIButton = {
        let button = UIButton()
        
        //Use color manager to change the backgroundColor to the color determined by Sabrina and design mentor.
        button.backgroundColor = SplashColor.darkPrimaryColor()
        
        button.layer.cornerRadius = 5
        button.setTitle("Add Profile Picture", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addShadows()
        //button.addTarget(self, action: #selector(), for: .touchUpInside)
        
        return button
        
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        
        //Use color manager to change the backgroundColor to the color determined by Sabrina and design mentor.
        button.backgroundColor = SplashColor.darkPrimaryColor()
        
        button.layer.cornerRadius = 10
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addShadows()
        //button.addTarget(self, action: #selector(), for: .touchUpInside)
        
        return button
    }()

    lazy var stackview: UIStackView = {
        let view1 = UIView()
        view1.backgroundColor = UIColor.orange
        view1.layer.cornerRadius = 5
        view1.addShadows()
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.black
        view2.layer.cornerRadius = 5
        view2.addShadows()
        
        let view3 = UIView()
        view3.backgroundColor = UIColor.green
        view3.layer.cornerRadius = 5
        view3.addShadows()
        
        let view4 = UIView()
        view4.backgroundColor = UIColor.red
        view4.layer.cornerRadius = 5
        view4.addShadows()
        
        let stackview = UIStackView(arrangedSubviews: [view1, view2, view3, view4])
        stackview.axis = .horizontal
        stackview.spacing = 10.0
        stackview.distribution = .fillEqually
        
        return stackview
    }()
}
