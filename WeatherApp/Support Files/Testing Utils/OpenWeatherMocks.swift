//
//  OpenWeatherResponse.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import Foundation

extension OpenWeatherResponse {
    
    static var mockLondon: OpenWeatherResponse {
        JSONDecoder.decode(jsonFile: "OpenWeatherResponseLondon.json")
    }
    
    static var mockMadrid: OpenWeatherResponse {
        JSONDecoder.decode(jsonFile: "OpenWeatherResponseMadrid.json")
    }
    
}

extension OpenWeatherAPIError {
    
    static var mock: OpenWeatherAPIError {
        JSONDecoder.decode(jsonFile: "OpenWeatherAPIErrorMock.json")
    }
    
}
