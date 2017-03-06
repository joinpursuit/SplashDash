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
    let runs: [Run]
    
    //MARK: - Initializer
    init(email: String, username: String, uid: String, teamName: String, runs: [Run]) {
        self.email = email
        self.username = username
        self.uid = uid
        self.teamName = teamName
        self.runs = runs
    }
}
