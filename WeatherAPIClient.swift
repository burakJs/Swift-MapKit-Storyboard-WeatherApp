//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Burak İmdat on 27.08.2021.
//

import Foundation

class WeatherAPIClient {
    fileprivate let apiKey = "d84fb2381f644f9686638c2f1e7d4769"
    
    lazy var baseURL: URL = {
        return URL(string: "https://api.weatherbit.io/v2.0/")!
    }()
    
    let jsonDownloader = JSONDownloader()
    
    typealias CurrentWeatherTypeCompletionHandler = (CurrentWeather?, WeatherAPIError?) -> Void
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherTypeCompletionHandler) {
        guard let url = URL(string: "current?key=\(self.apiKey)&" + coordinate.description,relativeTo: baseURL) else {
            completion(nil, WeatherAPIError.InvalidURL)
            return
        }
        
        let requestURL = URLRequest(url: url)
        let task = jsonDownloader.jsonTask(with: requestURL){ json, error in
            
            guard let json = json else {
                completion(nil, error)
                return
            }
            
            // Doğru bir json nesnesine sahibiz
            
            completion(CurrentWeather(json: json),nil)
        }
        
        task.resume()
    }
}
