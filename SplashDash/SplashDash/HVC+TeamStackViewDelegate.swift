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
    func cyanImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("CYAN")
        
        self.view.backgroundColor = UIColor(hex: SplashColor.colorsDict["tealTeamColor"]!, alpha: 1.0)
        self.emailTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["tealTeamColor"]!, alpha: 1.0)
        self.emailTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["tealTeamColor"]!, alpha: 1.0)
        
        self.usernameTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["tealTeamColor"]!, alpha: 1.0)
        self.usernameTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["tealTeamColor"]!, alpha: 1.0)
        
        self.passwordTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["tealTeamColor"]!, alpha: 1.0)
        self.passwordTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["tealTeamColor"]!, alpha: 1.0)
        
        self.loginRegisterButton.backgroundColor = UIColor(hex: SplashColor.colorsDict["tealTeamColor"]!, alpha: 1.0)
        self.loginRegisterButton.layer.borderColor = UIColor(hex: SplashColor.colorsDict["tealTeamColor"]!, alpha: 1.0).cgColor
        
        self.hiddenLabel.textColor = UIColor(hex: SplashColor.colorsDict["tealTeamColor"]!, alpha: 1.0)
    }
    
    func orangeImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("ORANGE")
        
        self.view.backgroundColor = UIColor(hex: SplashColor.colorsDict["orangeTeamColor"]!, alpha: 1.0)
        self.emailTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["orangeTeamColor"]!, alpha: 1.0)
        self.emailTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["orangeTeamColor"]!, alpha: 1.0)
        
        self.usernameTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["orangeTeamColor"]!, alpha: 1.0)
        self.usernameTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["orangeTeamColor"]!, alpha: 1.0)
        
        self.passwordTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["orangeTeamColor"]!, alpha: 1.0)
        self.passwordTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["orangeTeamColor"]!, alpha: 1.0)
        
        self.loginRegisterButton.backgroundColor = UIColor(hex: SplashColor.colorsDict["orangeTeamColor"]!, alpha: 1.0)
        self.loginRegisterButton.layer.borderColor = UIColor(hex: SplashColor.colorsDict["orangeTeamColor"]!, alpha: 1.0).cgColor
        
        self.hiddenLabel.textColor = UIColor(hex: SplashColor.colorsDict["orangeTeamColor"]!, alpha: 1.0)
    }
    
    func greenImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("GREEN")
        
        self.view.backgroundColor = UIColor(hex: SplashColor.colorsDict["greenTeamColor"]!, alpha: 1.0)
        self.emailTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["greenTeamColor"]!, alpha: 1.0)
        self.emailTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["greenTeamColor"]!, alpha: 1.0)
        
        self.usernameTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["greenTeamColor"]!, alpha: 1.0)
        self.usernameTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["greenTeamColor"]!, alpha: 1.0)
        
        self.passwordTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["greenTeamColor"]!, alpha: 1.0)
        self.passwordTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["greenTeamColor"]!, alpha: 1.0)
        
        self.loginRegisterButton.backgroundColor = UIColor(hex: SplashColor.colorsDict["greenTeamColor"]!, alpha: 1.0)
        self.loginRegisterButton.layer.borderColor = UIColor(hex: SplashColor.colorsDict["greenTeamColor"]!, alpha: 1.0).cgColor
        
        self.hiddenLabel.textColor = UIColor(hex: SplashColor.colorsDict["greenTeamColor"]!, alpha: 1.0)
    }
    
    func purpleImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("PURPLE")
        
        self.view.backgroundColor = UIColor(hex: SplashColor.colorsDict["purpleTeamColor"]!, alpha: 1.0)
        self.emailTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["purpleTeamColor"]!, alpha: 1.0)
        self.emailTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["purpleTeamColor"]!, alpha: 1.0)
        
        self.usernameTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["purpleTeamColor"]!, alpha: 1.0)
        self.usernameTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["purpleTeamColor"]!, alpha: 1.0)
        
        self.passwordTextField.textLabel.textColor = UIColor(hex: SplashColor.colorsDict["purpleTeamColor"]!, alpha: 1.0)
        self.passwordTextField.textField.textColor = UIColor(hex: SplashColor.colorsDict["purpleTeamColor"]!, alpha: 1.0)
        
        self.loginRegisterButton.backgroundColor = UIColor(hex: SplashColor.colorsDict["purpleTeamColor"]!, alpha: 1.0)
        self.loginRegisterButton.layer.borderColor = UIColor(hex: SplashColor.colorsDict["purpleTeamColor"]!, alpha: 1.0).cgColor
        
        self.hiddenLabel.textColor = UIColor(hex: SplashColor.colorsDict["purpleTeamColor"]!, alpha: 1.0)
    }
}
