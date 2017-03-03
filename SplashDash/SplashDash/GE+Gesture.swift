//
//  GE+Gesture.swift
//  SplashDash
//
//  Created by Tong Lin on 3/2/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit

extension GameViewController{

    func addGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOnMap(sender:)))
        tap.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(tap)
    }
    
    func tappedOnMap(sender: UIGestureRecognizer) {
        if let tapGesture: UITapGestureRecognizer = sender as? UITapGestureRecognizer {
            switch (tapGesture.numberOfTapsRequired, tapGesture.numberOfTouchesRequired) {
            case (1, 1):
                print("Heck yea I was tapped")
                self.animateAllButtons()
            default:
                print("tap type was wrong!")
            }
        }
    }
}
