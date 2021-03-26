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

// sourcery: autoSpy
protocol WeatherViewModelProtocol {
    var dataSource: WeatherViewModelData { get }
    var dataSourcePublisher: Published<WeatherViewModelData>.Publisher { get }
        
    var isSaved: Bool { get }
    
    func saveCity() throws
    func updateCity() throws
    
    func requestForecast()
    func didPressCityList()
    func didPressTWC()
}

// MARK: View Protocol

protocol WeatherViewRepresentable: UICollectionViewCell {
    func configure(with section: WeatherViewSection, indexPath: IndexPath)
}

// MARK: Data Provider

// sourcery: autoSpy
protocol WeatherProviderProtocol {
    func isSaved(city: City) -> Bool
    func save(city: City) throws
    func forecast(for city: City) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>>
}
