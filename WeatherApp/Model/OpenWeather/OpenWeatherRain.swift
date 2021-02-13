//
//  OpenWeatherRain.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

struct OpenWeatherRain: Codable, Equatable {
    let threeHours: Float?

    private enum CodingKeys: String, CodingKey {
        case threeHours = "3h"
    }
}
