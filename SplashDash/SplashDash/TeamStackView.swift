//
//  TeamStackView.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/5/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol TeamStackViewDelegate {
    func tealImageViewTapped(_ sender: UITapGestureRecognizer)
    func orangeImageViewTapped(_ sender: UITapGestureRecognizer)
    func greenImageViewTapped(_ sender: UITapGestureRecognizer)
    func purpleImageViewTapped(_ sender: UITapGestureRecognizer)
}

class TeamStackView: UIView {
    //MARK: - Properties
    var tealImageView: UIImageView!
    var orangeImageView: UIImageView!
    var greenImageView: UIImageView!
    var purpleImageView: UIImageView!
    var stackview: UIStackView!
    
    var tealTapGestureRecognizer: UITapGestureRecognizer!
    var orangeTapGestureRecognizer: UITapGestureRecognizer!
    var greenTapGestureRecognizer: UITapGestureRecognizer!
    var purpleTapGestureRecognizer: UITapGestureRecognizer!
    
    var delegate: TeamStackViewDelegate?
    
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
        let logo = UIImage(named: "logoSplash")
        let colorableLogo = logo?.withRenderingMode(.alwaysTemplate)
        
        tealImageView = UIImageView(image: colorableLogo)
        tealImageView.contentMode = .scaleAspectFill
        tealImageView.isUserInteractionEnabled = true
        tealImageView.addShadows()
        tealImageView.tintColor = UIColor(hex: SplashColor.colorsDict["tealTeamColor"]!, alpha: alpha)
        
        orangeImageView = UIImageView(image: colorableLogo)
        orangeImageView.contentMode = .scaleAspectFill
        orangeImageView.isUserInteractionEnabled = true
        orangeImageView.addShadows()
        orangeImageView.tintColor = UIColor(hex: SplashColor.colorsDict["orangeTeamColor"]!, alpha: alpha)
        
        greenImageView = UIImageView(image: colorableLogo)
        greenImageView.contentMode = .scaleAspectFill
        greenImageView.isUserInteractionEnabled = true
        greenImageView.addShadows()
        greenImageView.tintColor = UIColor(hex: SplashColor.colorsDict["greenTeamColor"]!, alpha: alpha)
        
        purpleImageView = UIImageView(image: colorableLogo)
        purpleImageView.contentMode = .scaleAspectFill
        purpleImageView.isUserInteractionEnabled = true
        purpleImageView.addShadows()
        purpleImageView.tintColor = UIColor(hex: SplashColor.colorsDict["purpleTeamColor"]!, alpha: alpha)
        
        stackview = UIStackView(arrangedSubviews: [tealImageView, orangeImageView, greenImageView, purpleImageView])
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
        tealTapGestureRecognizer = UITapGestureRecognizer(target: self.delegate, action: #selector(self.delegate?.tealImageViewTapped(_:)))
        tealTapGestureRecognizer.cancelsTouchesInView = false
        tealTapGestureRecognizer.numberOfTapsRequired = 1
        tealTapGestureRecognizer.numberOfTouchesRequired = 1
        self.tealImageView.addGestureRecognizer(tealTapGestureRecognizer)
        
        orangeTapGestureRecognizer = UITapGestureRecognizer(target: self.delegate, action: #selector(self.delegate?.orangeImageViewTapped(_:)))
        orangeTapGestureRecognizer.cancelsTouchesInView = false
        orangeTapGestureRecognizer.numberOfTapsRequired = 1
        orangeTapGestureRecognizer.numberOfTouchesRequired = 1
        self.orangeImageView.addGestureRecognizer(orangeTapGestureRecognizer)
        
        greenTapGestureRecognizer = UITapGestureRecognizer(target: self.delegate, action: #selector(self.delegate?.greenImageViewTapped(_:)))
        greenTapGestureRecognizer.cancelsTouchesInView = false
        greenTapGestureRecognizer.numberOfTapsRequired = 1
        greenTapGestureRecognizer.numberOfTouchesRequired = 1
        self.greenImageView.addGestureRecognizer(greenTapGestureRecognizer)
        
        purpleTapGestureRecognizer = UITapGestureRecognizer(target: self.delegate, action: #selector(self.delegate?.purpleImageViewTapped(_:)))
        purpleTapGestureRecognizer.cancelsTouchesInView = false
        purpleTapGestureRecognizer.numberOfTapsRequired = 1
        purpleTapGestureRecognizer.numberOfTouchesRequired = 1
        self.purpleImageView.addGestureRecognizer(purpleTapGestureRecognizer)
    }
}
