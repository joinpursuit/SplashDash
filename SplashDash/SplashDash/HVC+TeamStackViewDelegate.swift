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
        
        //animate view with vibration upon selection
        self.toggleShadows()
        self.stackview.tealImageView.vibrationAnimation()
        
        let defaults = UserDefaults()
        defaults.set(teamName.rawValue, forKey: "teamName")
    }
    
    func orangeImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("ORANGE")
        
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
        
        //animate view with vibration upon selection
        self.toggleShadows()
        self.stackview.orangeImageView.vibrationAnimation()
        
        let defaults = UserDefaults()
        defaults.set(teamName.rawValue, forKey: "teamName")
    }
    
    func greenImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("GREEN")
        
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
        
        //animate view with vibration upon selection
        self.toggleShadows()
        self.stackview.greenImageView.vibrationAnimation()
        
        let defaults = UserDefaults()
        defaults.set(teamName.rawValue, forKey: "teamName")
    }
    
    func purpleImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("PURPLE")
        
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
        
        //animate view with vibration upon selection
        self.toggleShadows()
        self.stackview.purpleImageView.vibrationAnimation()
        
        let defaults = UserDefaults()
        defaults.set(teamName.rawValue, forKey: "teamName")
    }
    
    func toggleShadows() {
        switch self.teamName.rawValue {
        case "teal":
            self.stackview.tealImageView.addShadows()
            self.stackview.orangeImageView.removeShadows()
            self.stackview.greenImageView.removeShadows()
            self.stackview.purpleImageView.removeShadows()
        case "orange":
            self.stackview.orangeImageView.addShadows()
            self.stackview.tealImageView.removeShadows()
            self.stackview.greenImageView.removeShadows()
            self.stackview.purpleImageView.removeShadows()
        case "green":
            self.stackview.greenImageView.addShadows()
            self.stackview.orangeImageView.removeShadows()
            self.stackview.tealImageView.removeShadows()
            self.stackview.purpleImageView.removeShadows()
        case "purple":
            self.stackview.purpleImageView.addShadows()
            self.stackview.orangeImageView.removeShadows()
            self.stackview.greenImageView.removeShadows()
            self.stackview.tealImageView.removeShadows()
        default:
            self.stackview.tealImageView.removeShadows()
            self.stackview.orangeImageView.removeShadows()
            self.stackview.greenImageView.removeShadows()
            self.stackview.purpleImageView.removeShadows()
        }
    }
}
