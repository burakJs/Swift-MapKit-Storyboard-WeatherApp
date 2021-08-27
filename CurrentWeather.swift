//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Burak İmdat on 26.08.2021.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let windSpeed: Double
    let summary: String // Weather/description
    let humidity: Double
    let city: String
    
    init(temperature: Double, windSpeed: Double, summary: String, humidity: Double,city: String) {
        self.temperature = temperature
        self.windSpeed = windSpeed
        self.summary = summary
        self.humidity = humidity
        self.city = city
    }
}

extension CurrentWeather {
    var iconImage: UIImage  {
        if summary.lowercased().contains("clear") {
            return #imageLiteral(resourceName: "clear-day")
        } else if summary.lowercased().contains("rain") {
            return #imageLiteral(resourceName: "rain")
        }
        else if summary.lowercased().contains("snow") {
           return #imageLiteral(resourceName: "snow")
        }
        else if summary.lowercased().contains("sleet") {
           return #imageLiteral(resourceName: "sleet")
        }
        else if summary.lowercased().contains("fog") {
           return #imageLiteral(resourceName: "fog")
        }
        else if summary.lowercased().contains("overcast") {
           return #imageLiteral(resourceName: "cloudy")
        }
        else if summary.lowercased().contains("cloud") {
           return #imageLiteral(resourceName: "partly-cloudy-day")
        }
        else {
           return #imageLiteral(resourceName: "default")
        }
    }
}

extension CurrentWeather {
    struct Key {
        static let temperature = "temp"
        static let summary = "description"
        static let summaryBase = "weather"
        static let windSpeed = "wind_spd"
        static let humidity = "rh"
        static let city = "city_name"
    }
    
    init?(json: [String: AnyObject]){
        guard let summaryBase = json[Key.summaryBase] else { return nil }
        guard let temp = json[Key.temperature] as? Double,
              let summary = summaryBase[Key.summary] as? String,
              let windSpeed = json[Key.windSpeed] as? Double,
              let humidity = json[Key.humidity] as? Double,
              let city = json[Key.city] as? String
              else { return nil }
        
        self.humidity = humidity
        self.summary = summary
        self.temperature = temp
        self.windSpeed = windSpeed
        self.city = city
    }
}
