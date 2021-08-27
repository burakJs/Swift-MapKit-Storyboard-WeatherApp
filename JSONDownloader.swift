//
//  JSONDownloader.swift
//  WeatherApp
//
//  Created by Burak İmdat on 26.08.2021.
//

import Foundation

class JSONDownloader {
    let session: URLSession
    
    init(config: URLSessionConfiguration) {
        self.session = URLSession(configuration: config)
    }
    
    convenience init() {
        self.init(config: URLSessionConfiguration.default)
    }
    
    typealias JSON = [String: AnyObject]
    typealias JSONDownloaderCompletionHandler = (JSON?, WeatherAPIError?) -> Void
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONDownloaderCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request){ data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil,WeatherAPIError.RequestError)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                        guard let jsonData = json?["data"], let jsonDataFirst = jsonData[0] as? JSON else { return completion(nil, WeatherAPIError.JSONParsingError) }
                        completion(jsonDataFirst, nil)
                    } catch  {
                        completion(nil, WeatherAPIError.JSONParsingError)
                    }
                } else {
                    // Data da sorun varsa veya elde edilemediyse
                    completion(nil, WeatherAPIError.InvalidData)
                }
            } else {
                completion(nil, WeatherAPIError.ResponseUnsuccessful(statusCode: httpResponse.statusCode))
            }
             
        }
        return task
    }
}
