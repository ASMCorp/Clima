//
//  WeatherData.swift
//  Clima
//
//  Created by Asaduzzaman Anik on 6/17/20.
//  Copyright © 2020 Asaduzzaman Anik. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
