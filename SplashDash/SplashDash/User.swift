//
//  User.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/6/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import Foundation

enum UserTeam: String {
    case teal, purple, orange, green
}

class User {
    //MARK: - Properties
    let email: String
    let username: String
    let uid: String
    let teamName: UserTeam
    var runs: [Run]
    
    //MARK: - Initializer
    init(email: String, username: String, uid: String, teamName: UserTeam, runs: [Run]) {
        self.email = email
        self.username = username
        self.uid = uid
        self.teamName = teamName
        self.runs = runs
    }
    
    convenience init?(_ validDict: NSDictionary) {
//        let allCoordinates = [SplashCoordinate]()
//        let runs = Run(allCoordinates: [])
        
        guard let email = validDict["email"] as? String,
            let username = validDict["username"] as? String,
            let uid = validDict["uid"] as? String,
            let teamName = validDict["teamName"] as? String,
            let userTeam = UserTeam(rawValue: teamName)
        else {
                print("!!!!!Error parsing current user!!!!!")
                return nil
        }
        
        var allRuns = [Run]()
        
        if let runsArr = validDict["runs"] as? [String: AnyObject]{
            for run in runsArr.values {
                guard let coordsInRun = run["allCoordinates"] as? [[String:AnyObject]],
                    let totalDistance = run["totalDistance"] as? Double,
                    let runDuration = run["runDuration"] as? Int
                    else { continue }
                
                var splashCoords = [SplashCoordinate]()
                for coordinate in coordsInRun {
                    if let coord = SplashCoordinate(coordinate as NSDictionary) {
                        splashCoords.append(coord)
                    }
                }
                allRuns.append(Run(allCoordinates: splashCoords, totalDistance: totalDistance, runDuration: runDuration))
            }
        }
        self.init(email: email, username: username, uid: uid, teamName: userTeam, runs: allRuns)
        
    }
    
    //MARK: - Methods
    func toData() -> [String: Any]{
        return ["email": self.email,
                "username": self.username,
                "uid": self.uid,
                "teamName": self.teamName.rawValue,
                "runs": self.runs] as [String: Any]
    }
}
