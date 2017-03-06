//
//  GE+SnapKit.swift
//  SplashDash
//
//  Created by Tong Lin on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit

extension GameViewController{
    
    func configureConstraints(){
        mapView.snp.remakeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
        
        bottomRootView.snp.remakeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            view.height.equalToSuperview()
            view.top.equalTo(self.view.snp.bottom).inset(100.0)
        }
        
        bottomView.snp.remakeConstraints { (view) in
            view.leading.top.trailing.bottom.equalToSuperview()
        }
        
        gameButton.snp.remakeConstraints { (view) in
            view.bottom.equalTo(bottomRootView.snp.top).offset(-30)
            view.trailing.equalToSuperview().offset(-30)
            view.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        findMeButton.snp.remakeConstraints { (view) in
            view.trailing.equalTo(gameButton)
            view.bottom.equalTo(gameButton.snp.top).offset(-40)
            view.size.equalTo(CGSize(width: 70, height: 70))
        }
    }
}
