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
        storage.savedCities
    }
    
    func save(city: City) throws {
        try storage.save(city: city)
    }
    
    func delete(city: City) throws {
        try storage.delete(city: city)
    }
    
    func move(city: City, to index: Int) throws {
        try storage.move(city: city, to: index)
    }
    
}
