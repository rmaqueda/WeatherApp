//
//  CityListProtocols.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit
import Combine

// sourcery: autoSpy
protocol CityListViewModelProtocol {
    var cities: [City] { get }
    
    var temperatureUnit: TemperatureUnit { get }
    
    func toggleTemperatureUnit() throws
    
    func deleteCity(at index: Int) throws
    func moveCity(from: Int, to: Int) throws
    
    func presentCitySearch()
    func presentForecast(for city: City)
    func didPressTWC()
}
