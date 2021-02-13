//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation
import Combine

class WeatherRepository: WeatherRepositoryProtocol {
    private var dataSourceType: AplicationPreferences.DataSourceType = .api
    
    private let APIProvider: WeatherProviderProtocol
    private let localProvider: WeatherProviderProtocol

    required init(APIProvider: WeatherProviderProtocol, localProvider: WeatherProviderProtocol) {
        self.APIProvider = APIProvider
        self.localProvider = localProvider
    }
    
    func requestForecast(city: String) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>> {
        
        switch dataSourceType {
        case .api:
            return APIProvider.requestForecast(city: city)
        case .cache:
            return localProvider.requestForecast(city: city)
        }
    }
    
    func setDataSourceType(_ type: AplicationPreferences.DataSourceType) {
        dataSourceType = type
    }
    
}
