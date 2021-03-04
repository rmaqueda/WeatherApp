//
//  Persistence.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 20/02/2021.
//

import Foundation

class CityDiskStorage: CityStorageProtocol {
    private let citiesKey = "cities"
    private let userDefaults = UserDefaults.standard
    
    var cities: [City] = []
    
    init() {
        loadCities()
    }
    
    private func loadCities() {
        guard let data = userDefaults.data(forKey: citiesKey) else {
            return
        }
        
        cities = (try? JSONDecoder().decode([City].self, from: data)) ?? []
    }
    
    func isSaved(city: City) -> Bool {
        cities.contains(city)
    }
    
    func save(city: City) throws {
        if let index = cities.firstIndex(of: city) {
            cities.remove(at: index)
            cities.insert(city, at: index)
        } else {
            cities.append(city)
        }
        try save(cities)
    }
    
    func deleteCity(at index: Int) throws {
        cities.remove(at: index)
        try save(cities)
    }
    
    func moveCity(from: Int, to: Int) throws {
        let city = cities.remove(at: from)
        cities.insert(city, at: to)
        try save(cities)
    }
    
    private func save(_ cities: [City]) throws {
        let data = try JSONEncoder().encode(cities)
        userDefaults.set(data, forKey: citiesKey)
    }
    
}
