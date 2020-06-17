//
//  WeatherModel.swift
//  Clima
//
//  Created by Asaduzzaman Anik on 6/17/20.
//  Copyright © 2020 Asaduzzaman Anik. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temp: Double
    let conditionID: Int
    
    var tempString: String{
        return String(Int(temp.rounded()))
    }
    var conditionName: String{
        
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
        
    }
    
    
    
}
