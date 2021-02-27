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
    let apiClient: APIClientProtocol
    let storage: CityStorage
        
    func forecast(for city: City) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>> {
        apiClient.response(for: .get("onecall",
                                     parameters: ["lat": city.coordinate.lat, "lon": city.coordinate.lon],
                                     jsonDecoder: JSONDecoder.openWeatherDecoder))
    }
    
    func isSaved(city: City) -> Bool {
        storage.isSaved(city: city)
    }
    
    func save(city: City) throws {
        try storage.save(city: city)
    }
    
}
