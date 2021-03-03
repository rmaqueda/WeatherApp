//
//  WeatherViewDataModelMock.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import Foundation

extension WeatherViewModelData {
    
    static var mockSuccess: WeatherViewModelData {
        let apiResponse = OpenWeatherResponse.mockMadrid
        let mapper = WeatherViewModelMapper()
        let city = WeatherApp.City.mockMadrid
        
        return mapper.map(city: city, with: apiResponse)
    }

    static var mockError: WeatherViewModelData {
        WeatherViewModelData(error: APIClientError(APIError(statusCode: 400, error: OpenWeatherAPIError.mock)))
    }
    
}
