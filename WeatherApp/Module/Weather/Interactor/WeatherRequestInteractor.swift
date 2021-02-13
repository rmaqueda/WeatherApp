//
//  RequestForecastInteractor.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 07/02/2021.
//

import Foundation
import Combine

class WeatherRequestInteractor: WeatherRequestInteractorProtocol {
    private let preferences: AplicationPreferences
    private let repository: WeatherRepositoryProtocol
        
    init(preferences: AplicationPreferences, repository: WeatherRepositoryProtocol) {
        self.preferences = preferences
        self.repository = repository
    }
    
    // MARK: RequestForecastInteractorProtocol
    
    func requestForecast(for city: String?) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>> {
        repository.requestForecast(city: city ?? preferences.defaultCity)
    }
    
}
