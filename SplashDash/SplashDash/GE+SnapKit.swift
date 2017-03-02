//
//  GE+SnapKit.swift
//  SplashDash
//
//  Created by Tong Lin on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import Foundation
import SnapKit

extension GameViewController{
    func configureConstraints(){
        mapView.snp.makeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
        
        gameButton.snp.makeConstraints { (view) in
            view.bottom.equalToSuperview().offset(-30)
            view.trailing.equalToSuperview().offset(-30)
            view.size.equalTo(CGSize(width: 70, height: 70))
        }
        
    }
}
