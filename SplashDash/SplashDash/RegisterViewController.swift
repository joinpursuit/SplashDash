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
//        self.view.addSubview(teamColorView1)
//        self.view.addSubview(teamColorView2)
//        self.view.addSubview(teamColorView3)
//        self.view.addSubview(teamColorView4)
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
            view.leading.equalTo(containerView.snp.leading).offset(25.0)
            view.trailing.equalTo(containerView.snp.trailing).inset(25.0)
        }
        
        //usernameTextField
        usernameTextField.snp.makeConstraints { (view) in
            view.top.equalTo(addProfilePicButton.snp.bottom).offset(16.0)
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
            view.bottom.equalTo(containerView.snp.bottom).inset(8.0)
            view.width.equalTo(avatarImageView.snp.width)
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
        textField.font = UIFont.systemFont(ofSize: 12.0)
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.addShadows()
        
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 12.0)
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.addShadows()
        
        return textField
    }()
    
    lazy var avatarImageView: UIImageView = {
        
        //replace this image with a better looking placeholder
        let image = UIImage(named: "user-icon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Select a team:"
        
        return label
    }()
    
    lazy var addProfilePicButton: UIButton = {
        let button = UIButton()
        
        //Use color manager to change the backgroundColor to the color determined by Sabrina and design mentor.
        button.backgroundColor = SplashColor.darkPrimaryColor()
        
        button.layer.cornerRadius = 10
        button.setTitle("Add Profile Picture", for: .normal)
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
    
    lazy var teamColorView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        
        return view
    }()
    
    
    lazy var teamColorView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        
        return view
    }()
    
    
    lazy var teamColorView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        
        return view
    }()
    
    
    lazy var teamColorView4: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        
        return view
    }()
    
    lazy var stackview: UIStackView = {
        let view1 = UIView()
        view1.backgroundColor = UIColor.orange
        view1.layer.cornerRadius = 5
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.black
        view2.layer.cornerRadius = 5
        
        let view3 = UIView()
        view3.backgroundColor = UIColor.green
        view3.layer.cornerRadius = 5
        
        let view4 = UIView()
        view4.backgroundColor = UIColor.red
        view4.layer.cornerRadius = 5
        
        let stackview = UIStackView(arrangedSubviews: [view1, view2, view3, view4])
        stackview.axis = .horizontal
        stackview.spacing = 8.0
        stackview.distribution = .fillEqually
        
        return stackview
    }()
}
