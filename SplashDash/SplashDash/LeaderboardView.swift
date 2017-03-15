//
//  LeaderboardView.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/12/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit

class LeaderboardView: UIView {
    //MARK: - Properties
    var circularContainerView: UIView!
    var rankingLabel: UILabel!
    var teamNameLabel: UILabel!
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Methods
    func setUpViewHierarchy() {
        self.circularContainerView = UIView()
        self.circularContainerView.backgroundColor = UIColor.lightGray
        self.circularContainerView.layer.cornerRadius = 17.5
        self.circularContainerView.alpha = 0.40
        self.addSubview(self.circularContainerView)
        
        self.rankingLabel = UILabel()
        self.rankingLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        self.rankingLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.addSubview(self.rankingLabel)
        
        self.teamNameLabel = UILabel()
        self.teamNameLabel.textColor = UIColor.white
        self.teamNameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.addSubview(self.teamNameLabel)
        
        self.alpha = 0.9
    }
    
    func configureConstraints() {
        self.circularContainerView.snp.makeConstraints { (view) in
            view.centerY.equalTo(self)
            view.leading.equalTo(self).offset(3.0)
            view.height.width.equalTo(35)
        }
        
        self.rankingLabel.snp.makeConstraints { (view) in
            view.centerX.centerY.equalTo(self.circularContainerView)
        }
        
        self.teamNameLabel.snp.makeConstraints { (view) in
            view.leading.equalTo(self.circularContainerView.snp.trailing).offset(10.0)
            view.centerY.equalTo(self)
        }
    }
}
