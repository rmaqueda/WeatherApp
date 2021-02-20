//
//  OpenWeatherAPIError.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import Foundation

struct OpenWeatherAPIError: Error, Codable {
    let cod: String
    let message: String
}
