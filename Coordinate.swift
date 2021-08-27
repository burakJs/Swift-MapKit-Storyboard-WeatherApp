//
//  Coordinate.swift
//  WeatherApp
//
//  Created by Burak İmdat on 27.08.2021.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "lat=\(latitude)&lon=\(longitude)"
    }
    
    static var alcatrazIsland: Coordinate {
        return Coordinate(latitude: 35.7796, longitude: -78.6382)
    }
}
