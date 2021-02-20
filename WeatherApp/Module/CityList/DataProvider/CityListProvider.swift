//
//  CityListProvider.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Combine

class CityListProvider: CityListProviderProtocol {
    private let storage: CityStorage
    
    var savedCities: [City] {
        storage.savedCities
    }
    
    required init(storage: CityStorage) {
        self.storage = storage
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
