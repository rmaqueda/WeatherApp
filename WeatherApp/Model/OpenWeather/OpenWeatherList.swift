//
//  OpenWeatherList.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

struct OpenWeatherList: Codable, Equatable {
    let main: OpenWeatherMain
    let clouds: OpenWeatherClouds
    let weather: [OpenWeatherWeather]
    let date: Date
    let rain: OpenWeatherRain?
    let wind: OpenWeatherWind

    private enum CodingKeys: String, CodingKey {
        case main
        case clouds
        case weather
        case date = "dt"
        case rain
        case wind
    }
}
