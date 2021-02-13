//
//  OpenWeatherWind.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

struct OpenWeatherWind: Codable, Equatable {
    let degrees: Float
    let speed: Float

    private enum CodingKeys: String, CodingKey {
        case degrees = "deg"
        case speed
    }

}
