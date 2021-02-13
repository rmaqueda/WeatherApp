//
//  OpenWeatherWeather.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

struct OpenWeatherWeather: Codable, Equatable {
    let main: String
    let icon: String
    let descriptionText: String
    let identifier: Int

    private enum CodingKeys: String, CodingKey {
        case main
        case icon
        case descriptionText = "description"
        case identifier = "id"
    }

}
