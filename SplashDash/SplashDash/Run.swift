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
    let timeStamp: Date
    let runDuration: Double
    let averageSpeed: Double
    
    //MARK: - Initializer
    init(allCoordinates: [SplashCoordinate], totalDistance: Double, dateTimeStamp: Date, runDuration: Double, averageSpeed: Double) {
        self.allCoordinates = allCoordinates
        self.totalDistance = totalDistance
        self.timeStamp = dateTimeStamp
        self.runDuration = runDuration
        self.averageSpeed = averageSpeed
    }
    
    //MARK: - Methods
    func toData() -> [String: Any] {
        let allCoordinatesArray = self.allCoordinates.map { $0.toData() }
        
        return ["allCoordinates": allCoordinatesArray,
                "totalDistance": self.totalDistance,
                "timeStamp": self.timeStamp,
                "runDuration": self.runDuration,
                "averageSpeed": self.averageSpeed] as [String: Any]
    }
}
