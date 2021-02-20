//
//  City.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 20/02/2021.
//

import Foundation

struct City: Codable, Equatable {
    let name: String
    let coordinate: Coordenate
    let timeZone: TimeZone?
    var temperature: Int?
    
    struct Coordenate: Codable, Equatable {
        let lat: Double
        let lon: Double
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.name == rhs.name && lhs.coordinate == rhs.coordinate
    }
    
}
