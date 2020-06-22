//
//  WeatherDelegate.swift
//  Clima
//
//  Created by Asaduzzaman Anik on 6/22/20.
//  Copyright © 2020 Asaduzzaman Anik. All rights reserved.
//

import UIKit

//this delegate was put in place to pass values to vc easily.
protocol WeatherManagerDelegate {
    
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}
