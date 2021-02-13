//
//  OpenWeatherResponse.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//
// API Doc: https://openweathermap.org/forecast5

import Foundation

struct OpenWeatherResponse: Codable, Equatable {
    let list: [OpenWeatherList]
    let code: String
    let count: Int?
    let message: Float
    let city: OpenWeatherCity

    private enum CodingKeys: String, CodingKey {
        case list
        case code = "cod"
        case count = "cnt"
        case message
        case city
    }

}
