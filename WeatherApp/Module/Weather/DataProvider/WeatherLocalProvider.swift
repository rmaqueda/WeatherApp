//
//  LocalForecastProvider.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import Foundation
import Combine

class WeatherLocalProvider: WeatherProviderProtocol {
    
    func requestForecast(city: String) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>> {
        Just(OpenWeatherResponse.mockLondon)
            .delay(for: 0.3, scheduler: DispatchQueue.main)
            .mapError(APIClientError<OpenWeatherAPIError>.init)
            .eraseToAnyPublisher()
    }
    
}
