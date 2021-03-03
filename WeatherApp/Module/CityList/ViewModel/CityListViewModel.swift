//
//  CityListViewModel.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation

struct CityListViewModel: CityListViewModelProtocol {
    var cities: [City] { provider.cities }
    let provider: CityListProviderProtocol
    let wireframe: Wireframe
    var unitTemperature: UnitTemperature = .celsius
        
    // MARK: CityListViewModelProtocol
    
    func deleteCity(at index: Int) throws {
        try provider.deleteCity(at: index)
    }
    
    func moveCity(from: Int, to: Int) throws {
        try provider.moveCity(from: from, to: to)
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
