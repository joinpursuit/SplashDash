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
    var totalDistance: Double {
        get{
            return Double(allCoordinates.count) * 50
        }
    }
    var timeStamp: Double {
        get{
            return (allCoordinates.first?.timestamp) ?? 0
        }
    }
    var runDuration: Double {
        get{
            guard let end = allCoordinates.last?.timestamp, let start = allCoordinates.first?.timestamp else { return 0.0 }
            return end - start
        }
    }
    var averageSpeed: Double {
        get{
            let total = allCoordinates.reduce(0.0) { (result, coor) in
                result + coor.speed
            }
            
            return total / Double(allCoordinates.count)
        }
    }
    
    //MARK: - Initializer
    init(allCoordinates: [SplashCoordinate]) {
        self.allCoordinates = allCoordinates
    }
    
    //MARK: - Methods
    func addCoordinate(coor: SplashCoordinate){
        self.allCoordinates.append(coor)
    }
    
    func reset(){
        self.allCoordinates = []
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
