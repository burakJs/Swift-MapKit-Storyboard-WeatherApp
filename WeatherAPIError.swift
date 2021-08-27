//
//  WeatherAPIError.swift
//  WeatherApp
//
//  Created by Burak İmdat on 26.08.2021.
//

import Foundation

enum WeatherAPIError {
    case RequestError
    case ResponseUnsuccessful(statusCode: Int)
    case InvalidData
    case JSONParsingError
    case InvalidURL
}
