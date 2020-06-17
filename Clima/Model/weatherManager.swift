//
//  weatherManager.swift
//  Clima
//
//  Created by Asaduzzaman Anik on 6/17/20.
//  Copyright © 2020 Asaduzzaman Anik. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct weatherManager {
    let mainUrl = "https://api.openweathermap.org/data/2.5/weather?appid=bc6de7d5978bb5e1fa06c310123a38ef&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func getWeather(cityName: String)  {
        let urlS = "\(mainUrl)&q=\(cityName)"
        processRequest(with: urlS)
        
    }
    
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlS = "\(mainUrl)&lat=\(latitude)&lon=\(longitude)"
        processRequest(with: urlS)
    }
    
    func processRequest(with urlS: String)  {
        if let url = URL(string: urlS){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weather =  self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let cityName = decodedData.name
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
                
            let weather = WeatherModel(cityName: cityName, temp: temp, conditionID: id)
            return weather
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
}
