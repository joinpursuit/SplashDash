//
//  BottomView.swift
//  SplashDash
//
//  Created by Sabrina Ip on 3/6/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit

class BottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupViewHierarchy() {
        self.addSubview(topView)
        self.addSubview(contentView)
        topView.addSubview(currentRunLabel)
        contentView.addSubview(contentCollectionView)
    }
    
    func configureConstraints() {
        currentRunLabel.snp.makeConstraints { (view) in
            view.leading.top.bottom.equalToSuperview().inset(8.0)
        }
        
        topView.snp.makeConstraints { (view) in
            view.leading.top.trailing.equalToSuperview()
        }
        
        contentCollectionView.snp.makeConstraints { (view) in
            view.leading.top.trailing.bottom.equalToSuperview().inset(8.0)
        }
        
        contentView.snp.makeConstraints { (view) in
            view.leading.trailing.bottom.equalToSuperview()
            view.top.equalTo(topView.snp.bottom)
        }
    }
    
    // MARK: - Views
    
        private lazy var topView: UIView = {
            let view = UIView()
            view.backgroundColor = SplashColor.darkPrimaryColor()
            view.clipsToBounds = true
            return view
        }()
    
        private lazy var currentRunLabel: UILabel = {
            let label = UILabel()
            label.text = "Duration of run: \("30 mins")\nDistance: \("2.1 miles")"
            label.textColor = SplashColor.lightPrimaryColor()
            label.numberOfLines = 0
            return label
        }()
    
        private lazy var contentView: UIView = {
            let view = UIView()
            view.backgroundColor = SplashColor.primaryColor()
            return view
        }()
    
        private lazy var contentCollectionView: ContentCollectionView = {
            let view = ContentCollectionView()
            return view
        }()


}
