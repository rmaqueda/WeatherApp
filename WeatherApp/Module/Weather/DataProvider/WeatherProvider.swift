//
//  WeatherProvider.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 29/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation
import Combine

struct WeatherProvider: WeatherProviderProtocol {
    private let apiClient: APIClientProtocol
    private let userPreferences: UserPreferencesProtocol
    
    init(apiClient: APIClientProtocol, userPreferences: UserPreferencesProtocol) {
        self.apiClient = apiClient
        self.userPreferences = userPreferences
    }
        
    func forecast(for city: City) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>> {
        apiClient.response(for: .get("onecall",
                                     parameters: ["lat": city.coordinate.latitude, "lon": city.coordinate.longitude],
                                     jsonDecoder: JSONDecoder.openWeatherDecoder))
    }
    
    func isSaved(city: City) -> Bool {
        userPreferences.cities.contains(city)
    }
    
    func save(city: City) throws {
        try userPreferences.save(city: city)
    }
    
}
