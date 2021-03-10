//
//  UserPreferences.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 08/03/2021.
//

import Foundation

// sourcery: autoSpy
protocol UserPreferencesProtocol {
    var cities: [City] { get }
    var temperatureUnit: TemperatureUnit { get }
    
    func save(city: City) throws
    func deleteCity(at index: Int) throws
    func moveCity(from: Int, to: Int) throws
    
    func toggleTemperatureUnit() throws
}

class UserPreferencesDisk: UserPreferencesProtocol {
    private let citiesKey = "cities"
    private let temperatureUnitKey = "temperatureUnit"
    private let userDefaults = UserDefaults.standard
    
    private(set) var cities: [City] = []
    private(set) var temperatureUnit: TemperatureUnit = .celsius
    
    init() {
        loadCities()
        loadTemperatureUnit()
    }
    
    private func loadCities() {
        guard let data = userDefaults.data(forKey: citiesKey) else {
            return
        }
        
        cities = (try? JSONDecoder().decode([City].self, from: data)) ?? []
    }
    
    private func loadTemperatureUnit() {
        if let rawValue = userDefaults.string(forKey: temperatureUnitKey) {
            self.temperatureUnit = TemperatureUnit(rawValue: rawValue) ?? TemperatureUnit.celsius
        }
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
    
    func toggleTemperatureUnit() throws {
        temperatureUnit.toggle()
        userDefaults.set(temperatureUnit.rawValue, forKey: temperatureUnitKey)
    }
    
    private func save(_ cities: [City]) throws {
        let data = try JSONEncoder().encode(cities)
        userDefaults.set(data, forKey: citiesKey)
    }
    
}
