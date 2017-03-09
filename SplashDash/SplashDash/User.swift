//
//  User.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/6/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import Foundation

class User {
    //MARK: - Properties
    let email: String
    let username: String
    let uid: String
    let teamName: String
    var runs: [Run]
    
    //MARK: - Initializer
    init(email: String, username: String, uid: String, teamName: String, runs: [Run]) {
        self.email = email
        self.username = username
        self.uid = uid
        self.teamName = teamName
        self.runs = runs
    }
    
    convenience init?(_ validDict: NSDictionary) {
        guard let email = validDict["email"] as? String,
            let username = validDict["username"] as? String,
            let uid = validDict["uid"] as? String,
            let teamName = validDict["teamName"] as? String else {
                print("!!!!!Error parsing current user!!!!!")
                return nil
        }
        
        self.init(email: email, username: username, uid: uid, teamName: teamName, runs: [])
    }
    
    //MARK: - Methods
    func toData() -> [String: Any]{
        return ["email": self.email,
                "username": self.username,
                "uid": self.uid,
                "teamName": self.teamName,
                "runs": []] as [String: Any]
    }
}
