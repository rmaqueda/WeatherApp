//
//  CityListProtocol.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit
import Combine

protocol CityListViewModelProtocol {
    var dataSource: [City] { get }
    var unitTemperature: UnitTemperature { get set }
    
    func deleteCity(at index: Int) throws
    func moveCity(from: Int, to: Int) throws
    
    func presentCitySearch()
    func presentForecast(for city: City)
}

protocol CityListProviderProtocol {
    var cities: [City] { get }
    
    func save(city: City) throws
    func delete(city: City) throws
    func move(city: City, to index: Int) throws
}
