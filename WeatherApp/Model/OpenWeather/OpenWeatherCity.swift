//
//  OpenWeatherCity.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation
import CoreLocation

struct OpenWeatherCity: Codable, Equatable {
    let name: String
    let identifier: Int
    let population: Int
    let country: String
    let timeZone: Int
    let coordinate: Coordenate
    let sunrise: Date
    let sunset: Date
    
    struct Coordenate: Codable, Equatable {
        let lat: Double
        let lon: Double
    }
    
    var CLLocationCoordinate2D: CLLocationCoordinate2D {
        CoreLocation.CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon)
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case identifier = "id"
        case coordinate = "coord"
        case population
        case country
        case timeZone = "timezone"
        case sunset
        case sunrise
    }
    
}
