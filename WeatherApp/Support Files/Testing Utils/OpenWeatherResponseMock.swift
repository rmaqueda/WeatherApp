//
//  OpenWeatherResponse.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import Foundation

extension OpenWeatherResponse {
    
    static var mockLondon: OpenWeatherResponse {
        JSONDecoder.decode(json: "OpenWeatherResponseLondon.json", type: self)
    }
    
    static var mockMadrid: OpenWeatherResponse {
        JSONDecoder.decode(json: "OpenWeatherResponseMadrid.json", type: self)
    }
    
}
