//
//  Persistence.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 20/02/2021.
//

import Foundation

protocol CityStorage {
    var savedCities: [City] { get }
    
    func isSaved(city: City) -> Bool
    func save(city: City) throws
    func delete(city: City) throws
    func move(city: City, to index: Int) throws
}

class CityDiskStorage: CityStorage {
    private let citiesKey = "cities"
    private let userDefaults = UserDefaults.standard
    
    var savedCities: [City] {
        if let data = userDefaults.data(forKey: citiesKey) {
            let cities = try? JSONDecoder().decode([City].self, from: data)
            return cities ?? []
        } else {
            return []
        }
    }
    
    func isSaved(city: City) -> Bool {
        savedCities.contains(city)
    }
    
    func save(city: City) throws {
        var cities = savedCities
        if let index = cities.firstIndex(of: city) {
            cities.remove(at: index)
            cities.insert(city, at: index)
        } else {
            cities.append(city)
        }
        try save(cities: cities)
    }
    
    func delete(city: City) throws {
        var cities = savedCities
        if let index = cities.firstIndex(of: city) {
            cities.remove(at: index)
            try save(cities: cities)
        }
    }
    
    private func save(cities: [City]) throws {
        let data = try JSONEncoder().encode(cities)
        userDefaults.set(data, forKey: citiesKey)
    }
    
    func move(city: City, to index: Int) throws {
        var cities = savedCities
        if let source = cities.firstIndex(of: city) {
            cities.remove(at: source)
            cities.insert(city, at: index)
        }
        try save(cities: cities)
    }
    
}
