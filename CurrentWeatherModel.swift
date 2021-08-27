//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Burak İmdat on 26.08.2021.
//

import Foundation
import UIKit

struct CurrentWeatherModel {
    let summary: String
    let temperature: String
    let humadity: String
    let windSpeed: String
    let icon: UIImage
    let city: String
    
    init(data: CurrentWeather) {
        self.summary = data.summary
        self.temperature = "\(data.temperature)°"
        self.windSpeed = "\(data.windSpeed) m/s"
        self.humadity = "\(data.humidity)%"
        self.icon = data.iconImage
        self.city = data.city
    }
}
