//
//  GE+Firebase.swift
//  SplashDash
//
//  Created by Tong Lin on 3/2/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import Firebase

extension GameViewController{
    
    func fetchGlobalSplash(){
        let linkRef = databaseReference.child("Public")
        
        linkRef.observe(FIRDataEventType.childAdded, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary{
                if let coor = SplashCoordinate(value){
                    
                    //draw all splashes parsed from database
                    let splash = SplashOverlay(park: coor)
                    self.mapView.addOverlays([splash])
                }
            }
            
            //            for child in snapshot.children{
//                if let snap = child as? FIRDataSnapshot, let valueDict = snap.value as? [String:AnyObject]{
//                    
//                    if let coor = SplashCoordinate(valueDict){
//                        //draw all splashes parsed from database
//                        let splash = SplashOverlay(park: coor)
//                        self.mapView.addOverlays([splash])
//                    }
//                }
//            }
        })
    }
    
    func pushSplashToDatabase(coor: SplashCoordinate){
        let linkRef = databaseReference.child("Public").childByAutoId()
        let data = coor.toData()
        
        linkRef.setValue(data) { (error, _) in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            print("Splash coordinate successfully stored.")
        }
    }
    
    
}
