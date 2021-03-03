//
//  CityListProvider.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Combine

struct CityListProvider: CityListProviderProtocol {
    let storage: CityStorage
    
    var cities: [City] {
        storage.cities
    }
    
    func save(city: City) throws {
        try storage.save(city: city)
    }
    
    func deleteCity(at index: Int) throws {
        try storage.deleteCity(at: index)
    }
    
    func moveCity(from: Int, to: Int) throws {
        try storage.moveCity(from: from, to: to)
    }
    
}
