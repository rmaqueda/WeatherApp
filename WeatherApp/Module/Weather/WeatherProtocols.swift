//
//  WeatherProtocols.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation
import Combine
import UIKit

// MARK: ViewModel

protocol WeatherViewModelProtocol {
    // Combine @Published property wrappers in protocols, see link above.
    var dataSource: WeatherViewModelData { get }
    var dataSourcePublished: Published<WeatherViewModelData> { get }
    var dataSourcePublisher: Published<WeatherViewModelData>.Publisher { get }
    
    func requestForecast(for city: String?)
    func cacheSwitchDidChange(isEnable: Bool)
}

// MARK: View Protocol

protocol WeatherViewRepresentable: UICollectionViewCell {
    func configure(with section: WeatherViewSectionData, indexPath: IndexPath)
}

// MARK: Interactors

// sourcery: autoSpy
protocol WeatherRequestInteractorProtocol {
    func requestForecast(for city: String?) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>>
}

// sourcery: autoSpy
protocol WeatherSetDataSourceInteractorProtocol {
    func changeDataSource(isCacheEnabled: Bool)
}

// MARK: Repository

// sourcery: autoSpy
protocol WeatherRepositoryProtocol {
    func requestForecast(city: String) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>>
    
    func setDataSourceType(_ type: AplicationPreferences.DataSourceType)
}

// MARK: Data Provider

// sourcery: autoSpy
protocol WeatherProviderProtocol {
    func requestForecast(city: String) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>>
}
