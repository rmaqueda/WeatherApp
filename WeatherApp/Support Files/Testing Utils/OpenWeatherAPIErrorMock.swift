//
//  OpenWeatherAPIError.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import Foundation

extension OpenWeatherAPIError {
    
    static var mock: OpenWeatherAPIError {
        JSONDecoder.decode(json: "OpenWeatherAPIErrorMock.json", type: self)
    }
    
}
