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

    var dataSource: [City] { provider.savedCities }
    
    var unitTemperature: UnitTemperature = .celsius
    
    private var cancellables = Set<AnyCancellable>()
    
    required init(provider: CityListProviderProtocol, wireframe: Wireframe) {
        self.provider = provider
        self.wireframe = wireframe
    }
    
    // MARK: CityListViewModelProtocol
    
    func delete(at index: Int) throws {
        let city = provider.savedCities[index]
        try provider.delete(city: city)
    }
    
    func moveCity(sourceIndex: Int, destinationIndex: Int) throws {
        let city = provider.savedCities[sourceIndex]
        try provider.move(city: city, to: destinationIndex)
    }
    
    func presentCitySearch() {
        wireframe.presentCitySearch()
    }
    
    func presentForecast(for city: City) {
        wireframe.presentForecast(for: city)
    }
    
}
