//
//  ViewController.swift
//  Clima
//
//  Created by Asaduzzaman Anik on 6/17/20.
//  Copyright © 2020 Asaduzzaman Anik. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var weatherM = weatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
       
        weatherM.delegate = self
        searchTextField.delegate = self
    }

    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
}

//MARK: - TextField Control

extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != ""{
            return true
        }
        else{
            searchTextField.placeholder = "Please Enter a City Name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text{
            weatherM.getWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherManager Controls

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather( weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = String(weather.tempString)
            self.cityNameLabel.text = weather.cityName
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
        }
        
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Current Location Contro;
extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lati = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherM.getWeather(latitude: lati, longitude: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    
}
