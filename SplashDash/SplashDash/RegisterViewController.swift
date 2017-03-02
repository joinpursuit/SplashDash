//
//  RegisterViewController.swift
//  SplashDash
//
//  Created by Tong Lin on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let image = UIImage(named: "user-icon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var label: UILabel = {
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
}
