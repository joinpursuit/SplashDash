//
//  Run.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/6/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import Foundation

class Run {
    //MARK: - Properties
    let allCoordinates: [SplashCoordinate]
    let totalDistance: Double
    let dateTimeStamp: Date
    let runDuration: Double
    let averageSpeed: Double
    
    //MARK: - Initializer
    init(allCoordinates: [SplashCoordinate], totalDistance: Double, dateTimeStamp: Date, runDuration: Double, averageSpeed: Double) {
        self.allCoordinates = allCoordinates
        self.totalDistance = totalDistance
        self.dateTimeStamp = dateTimeStamp
        self.runDuration = runDuration
        self.averageSpeed = averageSpeed
    }
}
