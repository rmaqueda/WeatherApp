//
//  APIForecastProvider.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import Foundation
import Combine

class WeatherAPIProvider: WeatherProviderProtocol {
    private let APIClient: APIClientProtocol
    
    init(APIClient: APIClientProtocol) {
        self.APIClient = APIClient
    }
    
    func requestForecast(city: String) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>> {
        APIClient.response(for: .get("forecast", parameters: ["q": city]))
            .delay(for: 0.3, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
