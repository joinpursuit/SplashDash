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
        
        linkRef.observeSingleEvent(of: .value, with: { (snapshot) in
            var allSplashes: [SplashOverlay] = []
            
            let validDict = snapshot.children
            while let coorSnapshot = validDict.nextObject() as? FIRDataSnapshot,
                  let value = coorSnapshot.value as? NSDictionary {
                    
                    if let coor = SplashCoordinate(value){
                        allSplashes.append(SplashOverlay(coor: coor))
                    }
            }
            //draw all splashes parsed from database
            self.invisibleMapView.addOverlays(allSplashes)
            self.mapView.addOverlays(allSplashes)
            //Add observe to GameHall
            print(allSplashes.count)
            self.observingNewSplash()
        })
    }
    
    func observingNewSplash(){
        let linkRef = databaseReference.child(getRootName()).child("GameHall")
        
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
        
        let linkRef = databaseReference.child(getRootName()).child("GameHall").childByAutoId()
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
        guard currentRunCoordinates.count > 0 else { return }
        
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
        guard let currentUserID = self.currentUser?.uid else { return }
        
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
    
    func endRunCoorsUpdate(){
        let todayRoom = databaseReference.child(getRootName())
        
        let gameHall = todayRoom.child("GameHall")
        
        //get each child coor belong to current user
        gameHall.queryOrdered(byChild: "userID").queryEqual(toValue: self.currentUser?.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let validDict = snapshot.children
            while let coor = validDict.nextObject() as? FIRDataSnapshot{
                //write to the new node
                todayRoom.child(coor.key).setValue(coor.value)
                //get a reference to the data we just read and remove it
                gameHall.child(coor.key).removeValue()
            
            }
        })
        
    }
    
}
