//
//  TeamStackView.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/5/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit

protocol TeamStackViewDelegate {
    
}

class TeamStackView: UIView {
    //MARK: - Properties
    var redImageView: UIImageView!
    var orangeImageView: UIImageView!
    var greenImageView: UIImageView!
    var purpleImageView: UIImageView!
    var stackview: UIStackView!
    
    var redTapGestureRecognizer: UITapGestureRecognizer!
    var orangeTapGestureRecognizer: UITapGestureRecognizer!
    var greenTapGestureRecognizer: UITapGestureRecognizer!
    var purpleTapGestureRecognizer: UITapGestureRecognizer!
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        addTapGestures()
    }
    
    //MARK: - Methods
    func setUpViewHierarchy() {
        //red team
        let redTeamLogo = UIImage(named: "redLogo")
        redImageView = UIImageView(image: redTeamLogo)
        redImageView.contentMode = .scaleAspectFill
        redImageView.isUserInteractionEnabled = true
        redImageView.addShadows()
        
        let orangeTeamLogo = UIImage(named: "orangeLogo")
        orangeImageView = UIImageView(image: orangeTeamLogo)
        orangeImageView.contentMode = .scaleAspectFill
        orangeImageView.isUserInteractionEnabled = true
        orangeImageView.addShadows()
        
        let greenTeamLogo = UIImage(named: "greenLogo")
        greenImageView = UIImageView(image: greenTeamLogo)
        greenImageView.contentMode = .scaleAspectFill
        greenImageView.isUserInteractionEnabled = true
        greenImageView.addShadows()
        
        let purpleTeamLogo = UIImage(named: "purpleLogo")
        purpleImageView = UIImageView(image: purpleTeamLogo)
        purpleImageView.contentMode = .scaleAspectFill
        purpleImageView.isUserInteractionEnabled = true
        purpleImageView.addShadows()
        
        stackview = UIStackView(arrangedSubviews: [redImageView, orangeImageView, greenImageView, purpleImageView])
        stackview.isUserInteractionEnabled = true
        stackview.axis = .horizontal
        stackview.spacing = 10.0
        stackview.distribution = .fillEqually
        
        self.addSubview(stackview)
    }
    
    func configureConstraints() {
        stackview.snp.makeConstraints { (view) in
            view.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Tap Gesture Methods
    func addTapGestures() {
        redTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(redImageViewTapped(_:)))
        redTapGestureRecognizer.cancelsTouchesInView = false
        redTapGestureRecognizer.numberOfTapsRequired = 1
        redTapGestureRecognizer.numberOfTouchesRequired = 1
        self.redImageView.addGestureRecognizer(redTapGestureRecognizer)
        
        orangeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(orangeImageViewTapped(_:)))
        orangeTapGestureRecognizer.cancelsTouchesInView = false
        orangeTapGestureRecognizer.numberOfTapsRequired = 1
        orangeTapGestureRecognizer.numberOfTouchesRequired = 1
        self.orangeImageView.addGestureRecognizer(orangeTapGestureRecognizer)
        
        greenTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(greenImageViewTapped(_:)))
        greenTapGestureRecognizer.cancelsTouchesInView = false
        greenTapGestureRecognizer.numberOfTapsRequired = 1
        greenTapGestureRecognizer.numberOfTouchesRequired = 1
        self.greenImageView.addGestureRecognizer(greenTapGestureRecognizer)
        
        purpleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(purpleImageViewTapped(_:)))
        purpleTapGestureRecognizer.cancelsTouchesInView = false
        purpleTapGestureRecognizer.numberOfTapsRequired = 1
        purpleTapGestureRecognizer.numberOfTouchesRequired = 1
        self.purpleImageView.addGestureRecognizer(purpleTapGestureRecognizer)
        
    }
    
    func redImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("RED IMAGE VIEW TAPPED")
    }
    
    func orangeImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("ORANGE IMAGE VIEW TAPPED")
    }
    
    func greenImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("GREEN IMAGE VIEW TAPPED")
    }
    
    func purpleImageViewTapped(_ sender: UITapGestureRecognizer) {
        print("PURPLE IMAGE VIEW TAPPED")
    }

}
