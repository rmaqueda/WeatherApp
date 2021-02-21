//
//  WeatherViewDataModelMock.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import Foundation

extension WeatherViewModelData {
    
    static var mockSuccess: WeatherViewModelData {
        let APIResponse = OpenWeatherResponse.mockLondon
        let mapper = WeatherViewModelMapper()
        
        return mapper.map(with: APIResponse)
    }
    
    static var mockMadrid: WeatherViewModelData {
        let APIResponse = OpenWeatherResponse.mockMadrid
        let mapper = WeatherViewModelMapper()
        
        return mapper.map(with: APIResponse)
    }
    
    static var mockError: WeatherViewModelData {
        WeatherViewModelData(error: APIClientError(APIError(statusCode: 400, error: OpenWeatherAPIError.mock)))
    }
    
}
