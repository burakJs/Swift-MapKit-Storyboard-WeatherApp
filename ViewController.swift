//
//  ViewController.swift
//  WeatherApp
//
//  Created by Burak İmdat on 26.08.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblHumidity: UILabel! // RH
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var btnRefresh: UIImageView!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var locationManager = CLLocationManager()
    let client = WeatherAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        btnRefresh.addGestureRecognizer(tapGesture)
        btnRefresh.isUserInteractionEnabled = true
        
        self.locationManager.delegate = self
//        When the application is opened, it asks the user to share the location information
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
//            Started to get location information
            locationManager.startUpdatingLocation()
        }
    }
    
//    when location is changed, This func will execute
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue: CLLocationCoordinate2D = manager.location!.coordinate
        let clientCoordinate = Coordinate(latitude: locationValue.latitude, longitude: locationValue.longitude)
        updateWeather(coordinate: clientCoordinate)
    }
    
    func updateWeather(coordinate: Coordinate){
        client.getCurrentWeather(at: coordinate){ currentWeather, error in
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherModel(data: currentWeather)
                
                DispatchQueue.main.sync {
                    self.showWeather(model: viewModel)
                }
            }
        }
    }
    
    func showWeather(model: CurrentWeatherModel) {
        lblTemp.text = model.temperature
        lblSummary.text = model.summary
        lblHumidity.text = model.humadity
        lblWindSpeed.text = model.windSpeed
        weatherIcon.image = model.icon
        lblCity.text = model.city
        indicator.stopAnimating()
        btnRefresh.backgroundColor = .systemTeal
    }
    
    @objc func imageTapped() {
        if indicator.isAnimating { return }
        indicator.startAnimating()
        btnRefresh.backgroundColor = .lightGray
        locationManager(locationManager, didUpdateLocations: [])
        
    }
}

