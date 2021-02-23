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
             coordinate: Coordenate.init(lat: 0.0, lon: 0.0),
             timeZone: nil,
             temperature: nil)
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
