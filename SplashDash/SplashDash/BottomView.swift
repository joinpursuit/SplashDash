//
//  BottomView.swift
//  SplashDash
//
//  Created by Sabrina Ip on 3/6/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit

class BottomView: UIView {

    let topViewSpacing: CGFloat = 100.0
    
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
        self.addSubview(seperatorLine)
        contentView.addSubview(contentCollectionView)
        topView.addSubview(currentRunLabel)
    }
    
    func configureConstraints() {
        currentRunLabel.snp.makeConstraints { (view) in
            view.leading.top.bottom.equalToSuperview().inset(8.0)
        }
        
        topView.snp.makeConstraints { (view) in
            view.leading.top.trailing.equalToSuperview()
            view.height.equalTo(self.topViewSpacing)
        }
        
        seperatorLine.snp.makeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            view.top.equalTo(topView.snp.bottom)
            view.height.equalTo(1.0)
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
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = SplashColor.primaryColor()
        return view
    }()
    
    private lazy var seperatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = SplashColor.lightPrimaryColor()
        return view
    }()
    
    lazy var currentRunLabel: UILabel = {
        let label = UILabel()
        var labelText = "Duration of run: \("30 mins")\nDistance: \("2.1 miles")"
        label.text = labelText
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
