//
//  City.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 20/02/2021.
//

import Foundation

enum TemperatureUnit: String {
    case celsius = "ºC"
    case fahrenheit = "ºF"
    
    mutating func toggle() {
        switch self {
        case .celsius:
            self = .fahrenheit
        case .fahrenheit:
            self = .celsius
        }
    }
}

struct City: Codable, Equatable {
    let name: String
    let coordinate: Coordinate
    let timeZone: TimeZone?
    
    var temperatureCelsius: Double?
    var temperatureString: String?
    
    struct Coordinate: Codable, Equatable {
        let latitude: Double
        let longitude: Double
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.name == rhs.name && lhs.coordinate == rhs.coordinate
    }
    
    mutating func setTemperatureString(temperatureUnit: TemperatureUnit) {
        guard let temperatureCelsius = temperatureCelsius else {
            return
        }
        if temperatureUnit == .celsius {
            temperatureString = NumberFormatter.celsiusString(celsius: temperatureCelsius)
        } else {
            temperatureString = NumberFormatter.fahrenheitString(celsius: temperatureCelsius)
        }
    }
    
}
