//
//  CityListViewModel.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation

struct CityListViewModel: CityListViewModelProtocol {
    var cities: [City] {
        userPreference.cities.map {
            var city = $0
            city.setTemperatureString(temperatureUnit: userPreference.temperatureUnit)
            return city
        }
    }
    
    var temperatureUnit: TemperatureUnit {
        userPreference.temperatureUnit
    }
    
    private let userPreference: UserPreferencesProtocol
    private let wireframe: WireframeProtocol
        
    init(userPreference: UserPreferencesProtocol, wireframe: WireframeProtocol) {
        self.userPreference = userPreference
        self.wireframe = wireframe
    }
    
    // MARK: CityListViewModelProtocol
    
    func toggleTemperatureUnit() throws {
        try userPreference.toggleTemperatureUnit()
    }
    
    func deleteCity(at index: Int) throws {
        try userPreference.deleteCity(at: index)
    }
    
    func moveCity(from: Int, to: Int) throws {
        try userPreference.moveCity(from: from, to: to)
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
