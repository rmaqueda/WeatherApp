//
//  WeatherProvider.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 29/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation
import Combine

class WeatherProvider: WeahterProviderProtocol {
    private let apiClient: APIClientProtocol
    private let storage: CityStorage
    
    required init(apiClient: APIClientProtocol, storage: CityStorage) {
        self.apiClient = apiClient
        self.storage = storage
    }
    
    func forecast(for city: City) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>> {
        apiClient.response(for: .get("forecast", parameters: ["q": city.name], jsonDecoder: JSONDecoder.openWeatherDecoder))
    }
    
    func isSaved(city: City) -> Bool {
        storage.isSaved(city: city)
    }
    
    func save(city: City) throws {
        try storage.save(city: city)
    }
    
}
