//
//  CityListViewModel.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation
import UIKit
import Combine

class CityListViewModel: CityListViewModelProtocol, ObservableObject {
    private let provider: CityListProviderProtocol
    private let wireframe: Wireframe

    var dataSource: [City] { provider.cities }
    
    var unitTemperature: UnitTemperature = .celsius
    
    private var cancellable = Set<AnyCancellable>()
    
    required init(provider: CityListProviderProtocol, wireframe: Wireframe) {
        self.provider = provider
        self.wireframe = wireframe
    }
    
    // MARK: CityListViewModelProtocol
    
    func deleteCity(at index: Int) throws {
        let city = provider.cities[index]
        try provider.delete(city: city)
    }
    
    func moveCity(from: Int, to: Int) throws {
        let city = provider.cities[from]
        try provider.move(city: city, to: to)
    }
    
    func presentCitySearch() {
        wireframe.presentCitySearch()
    }
    
    func presentForecast(for city: City) {
        wireframe.presentForecast(for: city)
    }
    
    func didPressTWC() {
        wireframe.presentTWCWeb()
    }
    
}
