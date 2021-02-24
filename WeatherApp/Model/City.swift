//
//  City.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 20/02/2021.
//

import Foundation

struct City: Codable, Equatable {
    let name: String
    let coordinate: Coordinate
    let timeZone: TimeZone?
    var temperature: String?
    
    struct Coordinate: Codable, Equatable {
        let lat: Double
        let lon: Double
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.name == rhs.name && lhs.coordinate == rhs.coordinate
    }
    
}
