//
//  LoginViewController.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import ISHPullUp

class LoginViewController: UIViewController {
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewHierarchy()
        configureConstraints()
        
        //Use color manager to change the backgroundColor to the color determined by Sabrina and design mentor.
        view.backgroundColor = SplashColor.primaryColor()
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
        }
    }
    
    func registerButtonPressed(sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            sender.transform = CGAffineTransform.identity
                        }
                        
                        //pass username and password to RegisterViewController if creating a new user
                        let registerVC = RegisterViewController()
                        registerVC.usernameTextField.text = self.usernameTextField.text
                        registerVC.passwordTextField.text = self.passwordTextField.text
                        
                        self.present(registerVC, animated: true, completion: nil)
        })
    }
    
    func loginButtonPressed(sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            sender.transform = CGAffineTransform.identity
                        }
                        
                        //Login via Firebase
                        guard let username = self.usernameTextField.text,
                            let password = self.passwordTextField.text else {
                                //setup hidden label
                                return
                        }
                        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: { (user: FIRUser?, error: Error?) in
                            if error != nil {
                                //setup hidden label
                            }
                            print("\(user?.uid)")
                        })
                        
                        let gameVC = GameViewController()
                        let userInfoVC = UserInfoViewController()
                        let ishPullUpVC = ISHPullUpViewController()
                        ishPullUpVC.contentViewController = gameVC
                        ishPullUpVC.bottomViewController = userInfoVC
                        
                        self.present(ishPullUpVC, animated: true, completion: nil)
        })
    }
    
    //MARK: - Lazy instantiation
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
    
    lazy var splashDashLogoImageView: UIImageView = {
        let image = UIImage(named: "splashDash-icon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        
        //Use color manager to change the backgroundColor to the color determined by Sabrina and design mentor.
        button.backgroundColor = SplashColor.darkPrimaryColor()
        
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addShadows()
        button.addTarget(self, action: #selector(loginButtonPressed(sender:)), for: .touchUpInside)
        
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
        button.addTarget(self, action: #selector(registerButtonPressed(sender:)), for: .touchUpInside)
        
        return button
    }()
    
}
