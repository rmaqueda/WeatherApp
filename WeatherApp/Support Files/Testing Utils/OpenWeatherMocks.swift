//
//  OpenWeatherResponse.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import Foundation

extension City {
        
    static var mockMadrid: City {
        City(name: "Madrid",
             coordinate: Coordinate.init(latitude: 0.0, longitude: 0.0),
             timeZone: nil)
    }
}

extension OpenWeatherResponse {
    
    static var mockMadrid: OpenWeatherResponse {
        JSONDecoder.decode(jsonFile: "OpenWeatherResponseMadrid.json")
    }
    
}

extension OpenWeatherAPIError {
    
    static var mock: OpenWeatherAPIError {
        JSONDecoder.decode(jsonFile: "OpenWeatherAPIErrorMock.json")
    }
    
}
