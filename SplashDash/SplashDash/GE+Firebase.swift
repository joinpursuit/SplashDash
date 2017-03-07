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
    
    func getRootName() -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        return format.string(from: Date())
    }
    
    func fetchGlobalSplash(){
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        let linkRef = databaseReference.child(getRootName())
        
        linkRef.observe(FIRDataEventType.childAdded, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary{
                if let coor = SplashCoordinate(value){
                    
                    //draw all splashes parsed from database
                    let splash = SplashOverlay(park: coor)
                    self.mapView.addOverlays([splash])
                }
            }
        })
    }
    
    func pushSplashToDatabase(coor: SplashCoordinate){
        let linkRef = databaseReference.child(getRootName()).childByAutoId()
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
