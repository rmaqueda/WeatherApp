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
    
    func requestForecast()
    
    var addButtonIsHiden: Bool { get }
    var cancelButtonIsHiden: Bool { get }
    
    func navigateToCityList()
    
    func saveCity() throws
    func saveCityIfNeeded() throws
}

// MARK: View Protocol

protocol WeatherViewRepresentable: UICollectionViewCell {
    func configure(with section: WeatherViewSectionData, indexPath: IndexPath)
}

// MARK: Data Provider

// sourcery: autoSpy
protocol WeahterProviderProtocol {
    func isSaved(city: City) -> Bool
    func save(city: City) throws
    func forecast(for city: City) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>>
}
