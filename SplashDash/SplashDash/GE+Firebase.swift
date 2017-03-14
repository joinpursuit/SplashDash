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
    
    func fetchCurrentUserData(){
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            
            let linkRef = FIRDatabase.database().reference().child("Users").child(uid)
            
            linkRef.observeSingleEvent(of: .value, with: { (snapshot) in
//                print("snapshot is \(snapshot)")
                if let value = snapshot.value as? NSDictionary{
                    if let user = User(value){
                        self.currentUser = user
                    }
                }
            })
        }
    }
    
    func fetchGlobalSplash(){
        let linkRef = databaseReference.child(getRootName())
        
        linkRef.observe(FIRDataEventType.childAdded, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary{
                if let coor = SplashCoordinate(value){
                    
                    //draw all splashes parsed from database
                    let splash = SplashOverlay(coor: coor)
                    self.invisibleMapView.addOverlays([splash])
                    self.mapView.addOverlays([splash])
                }
            }
        })
    }
    
    func pushSplashToDatabase(coor: SplashCoordinate){
        let linkRef = databaseReference.child(getRootName()).childByAutoId()
        let data = coor.toData()
        
        linkRef.setValue(data) { (error, _) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            // print("Splash coordinate successfully stored.")
        }
    }
    
    func uploadAndAddRun(){
        let thisRun = Run(allCoordinates: currentRunCoordinates, totalDistance: self.traveledDistanceInMeters, runDuration: self.duration)
        
        // add run
        self.currentUser?.runs.append(thisRun)
        let sortedRuns = self.currentUser?.runs.sorted {
            return $0.timeStamp > $1.timeStamp
        }
        if let runs = sortedRuns {
            bottomView.contentCollectionView.userRunHistoryView.userRuns = runs
        }
        
        //upload run
        guard let currentUserID = FIRAuth.auth()?.currentUser?.uid,
            currentRunCoordinates.count > 0 else { return }
        
        let linkRef = FIRDatabase.database().reference().child("Users").child(currentUserID).child("runs")
        

        let data = thisRun.toData()
        
        linkRef.childByAutoId().setValue(data) { (error, _) in
            if let error = error {
                print(error.localizedDescription)
            } else{
                print("Current run updated")
              
            }
        }
    }
    
}
