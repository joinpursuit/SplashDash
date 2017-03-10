//
//  HVC+TeamStackViewDelegate.swift
//  
//
//  Created by Harichandan Singh on 3/9/17.
//
//

import UIKit

extension HomeViewController: TeamStackViewDelegate {
    //MARK: - Methods
    func tealImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("TEAL")
        
        self.view.backgroundColor = UIColor(hex: SplashColor.colorsDict["teal"]!, alpha: 1.0)
        self.emailTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["teal"]!, alpha: 1.0)
        self.emailTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["teal"]!, alpha: 1.0)
        
        self.usernameTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["teal"]!, alpha: 1.0)
        self.usernameTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["teal"]!, alpha: 1.0)
        
        self.passwordTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["teal"]!, alpha: 1.0)
        self.passwordTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["teal"]!, alpha: 1.0)
        
        self.loginRegisterButton.backgroundColor = UIColor(hex: SplashColor.colorsDict["teal"]!, alpha: 1.0)
        self.loginRegisterButton.layer.borderColor = UIColor(hex: SplashColor.colorsDict["teal"]!, alpha: 1.0).cgColor
        
        self.hiddenLabel.textColor = UIColor(hex: SplashColor.colorsDict["teal"]!, alpha: 1.0)
        
        self.teamName = UserTeam.teal
        
        let defaults = UserDefaults()
        defaults.set(teamName.rawValue, forKey: "teamName")
    }
    
    func orangeImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("ORANGE")
        
        self.view.backgroundColor = UIColor(hex: SplashColor.colorsDict["orange"]!, alpha: 1.0)
        self.emailTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["orange"]!, alpha: 1.0)
        self.emailTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["orange"]!, alpha: 1.0)
        
        self.usernameTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["orange"]!, alpha: 1.0)
        self.usernameTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["orange"]!, alpha: 1.0)
        
        self.passwordTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["orange"]!, alpha: 1.0)
        self.passwordTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["orange"]!, alpha: 1.0)
        
        self.loginRegisterButton.backgroundColor = UIColor(hex: SplashColor.colorsDict["orange"]!, alpha: 1.0)
        self.loginRegisterButton.layer.borderColor = UIColor(hex: SplashColor.colorsDict["orange"]!, alpha: 1.0).cgColor
        
        self.hiddenLabel.textColor = UIColor(hex: SplashColor.colorsDict["orange"]!, alpha: 1.0)
        
        self.teamName = UserTeam.orange
        
        let defaults = UserDefaults()
        defaults.set(teamName.rawValue, forKey: "teamName")
    }
    
    func greenImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("GREEN")
        
        self.view.backgroundColor = UIColor(hex: SplashColor.colorsDict["green"]!, alpha: 1.0)
        self.emailTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["green"]!, alpha: 1.0)
        self.emailTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["green"]!, alpha: 1.0)
        
        self.usernameTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["green"]!, alpha: 1.0)
        self.usernameTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["green"]!, alpha: 1.0)
        
        self.passwordTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["green"]!, alpha: 1.0)
        self.passwordTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["green"]!, alpha: 1.0)
        
        self.loginRegisterButton.backgroundColor = UIColor(hex: SplashColor.colorsDict["green"]!, alpha: 1.0)
        self.loginRegisterButton.layer.borderColor = UIColor(hex: SplashColor.colorsDict["green"]!, alpha: 1.0).cgColor
        
        self.hiddenLabel.textColor = UIColor(hex: SplashColor.colorsDict["green"]!, alpha: 1.0)
        
        self.teamName = UserTeam.green
        
        let defaults = UserDefaults()
        defaults.set(teamName.rawValue, forKey: "teamName")
    }
    
    func purpleImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("PURPLE")
        
        self.view.backgroundColor = UIColor(hex: SplashColor.colorsDict["purple"]!, alpha: 1.0)
        self.emailTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["purple"]!, alpha: 1.0)
        self.emailTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["purple"]!, alpha: 1.0)
        
        self.usernameTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["purple"]!, alpha: 1.0)
        self.usernameTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["purple"]!, alpha: 1.0)
        
        self.passwordTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["purple"]!, alpha: 1.0)
        self.passwordTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["purple"]!, alpha: 1.0)
        
        self.loginRegisterButton.backgroundColor = UIColor(hex: SplashColor.colorsDict["purple"]!, alpha: 1.0)
        self.loginRegisterButton.layer.borderColor = UIColor(hex: SplashColor.colorsDict["purple"]!, alpha: 1.0).cgColor
        
        self.hiddenLabel.textColor = UIColor(hex: SplashColor.colorsDict["purple"]!, alpha: 1.0)
        
        self.teamName = UserTeam.purple
        
        let defaults = UserDefaults()
        defaults.set(teamName.rawValue, forKey: "teamName")
    }
}
