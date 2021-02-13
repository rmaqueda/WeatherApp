//
//  OpenWeatherClouds.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

struct OpenWeatherClouds: Codable, Equatable {
    let cloudiness: Int

    private enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}
