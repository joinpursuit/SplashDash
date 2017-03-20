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
    var allCoordinates: [SplashCoordinate]
    var totalDistance: Double

    var timeStamp: Double {
        get{
            return (allCoordinates.first?.timestamp) ?? 0
        }
    }
    var runDuration: Int

    var averageSpeed: Double {
        get{
            return totalDistance / Double(runDuration)
        }
    }
    
    //MARK: - Initializer
    init(allCoordinates: [SplashCoordinate], totalDistance: Double, runDuration: Int) {
        self.allCoordinates = allCoordinates
        self.totalDistance = totalDistance
        self.runDuration = runDuration
    }
    
    //MARK: - Methods
    func addCoordinate(coor: SplashCoordinate){
        self.allCoordinates.append(coor)
    }
    
    func toData() -> [String: Any] {
        let allCoordinatesArray = self.allCoordinates.map { $0.toData() }
        
        return ["allCoordinates": allCoordinatesArray,
                "totalDistance": self.totalDistance,
                "timeStamp": self.timeStamp,
                "runDuration": self.runDuration,
                "averageSpeed": self.averageSpeed] as [String: Any]
    }
}
