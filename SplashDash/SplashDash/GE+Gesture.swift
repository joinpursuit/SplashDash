//
//  GE+Gesture.swift
//  SplashDash
//
//  Created by Tong Lin on 3/2/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import MapKit

extension GameViewController{

//    func addGestures(){
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOnMap(sender:)))
//        tap.numberOfTapsRequired = 1
//        mapView.addGestureRecognizer(tap)
//    }
    
    func tappedOnMap(sender: UIGestureRecognizer) {
        guard let tapGesture: UITapGestureRecognizer = sender as? UITapGestureRecognizer else { return }
        switch (tapGesture.numberOfTapsRequired, tapGesture.numberOfTouchesRequired) {
        case (1, 1):
            print("Map was tapped once, with one finger")
            self.animateAllButtons()
        default:
            print("Map was tapped, but not with one finger!")
        }
        
    }
}
