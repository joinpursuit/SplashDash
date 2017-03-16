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
            while let coorSnapshot = validDict.nextObject() as? FIRDataSnapshot{
                if let value = coorSnapshot.value as? NSDictionary, let coor = SplashCoordinate(value){
                    allSplashes.append(SplashOverlay(coor: coor))
                }
            }
            //draw all splashes parsed from database
            self.mapView.addOverlays(allSplashes)
            //Add observe to GameHall
            print(allSplashes.count)
            
            //get current global score
            self.gameScoreManager(with: .get, score: nil)
            
            //add real-time observe for new splashes
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
    
    func gameScoreManager(with type: RequestType, score: [(color: String, score: Double)]?){
        let linkRef = databaseReference.child(getRootName()).child("Score")
        
        switch type {
        case .get:
            linkRef.observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary{
                    guard let purple = value["purple"] as? Double,
                        let teal = value["teal"] as? Double,
                        let green = value["green"] as? Double,
                        let orange = value["orange"] as? Double else{
                            print("!!!!!Error parsing game score!!!!!")
                            return
                    }
                    
                    self.currentScore = [("purple", purple),
                                         ("teal", teal),
                                         ("green", green),
                                         ("orange", orange)]
                    print(self.currentScore)
                    //updating leaderboard count and handle colors
                    self.updateLeaderboard()
                    
                }else{
                    print("No records found")
                }
            })
        case .set:
            if let value = score{
                var newScore: [String: Double] = [:]
                for item in value{
                    newScore[item.color] = item.score
                }
                
                linkRef.setValue(newScore, withCompletionBlock: { (error, ref) in
                    if error != nil{
                        print(error!.localizedDescription)
                    }else{
                        //updating leaderboard count and handle colors
                        self.updateLeaderboard()
                    }
                })
            }else{
                print("No valid score data")
            }
            
        }
    }
}

enum RequestType {
    case get, set
}
