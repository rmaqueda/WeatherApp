//
//  OpenWeatherMain.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

struct OpenWeatherMain: Codable, Equatable {
    let groundLevel: Float?
    let temperatureMin: Float?
    let temperatureMax: Float?
    let temperature: Float
    let seaLevel: Float?
    let pressure: Float?
    let humidity: Int?
    let temperatureKF: Float?

    private enum CodingKeys: String, CodingKey {
        case groundLevel = "grnd_level"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case temperature = "temp"
        case seaLevel = "sea_level"
        case pressure
        case humidity
        case temperatureKF = "temp_kf"
    }

}
