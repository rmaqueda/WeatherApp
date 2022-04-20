//
//  ForecastIcon.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//
// https://openweathermap.org/weather-conditions

import Foundation

enum ForecastIcon: String, Decodable {
    // Day
    case clearSky = "01d"
    case fewClouds = "02d"
    case scatteredClouds = "03d"
    case brokenClouds = "04d"
    case showerRain = "09d"
    case rain = "10d"
    case thunderstorm = "11d"
    case snow = "13d"
    case mist = "50d"
    
    // Night
    case clearSkyNight = "01n"
    case fewCloudsNight = "02n"
    case scatteredCloudsNight = "03n"
    case brokenCloudsNight = "04n"
    case showerRainNight = "09n"
    case rainNight = "10n"
    case thunderstormNight = "11n"
    case snowNight = "13n"
    case mistNight = "50n"
    
    case sunrise
    case sunset
    
    case unknown
    
    var sfSymbolName: String {
        switch self {
        case .clearSky:
            return "sun.max.fill"
        case .fewClouds:
            return "cloud.sun.fill"
        case .scatteredClouds:
            return "cloud.fill"
        case .brokenClouds:
            return "smoke.fill"
        case .showerRain:
            return "cloud.drizzle.fill"
        case .rain:
            return "cloud.rain.fill"
        case .thunderstorm:
            return "cloud.sun.bolt.fill"
        case .snow:
            return "snow"
        case .mist:
            return "cloud.fog.fill"
        case .clearSkyNight:
            return "moon.fill"
        case .fewCloudsNight:
            return "cloud.moon.fill"
        case .scatteredCloudsNight:
            return "cloud.fill"
        case .brokenCloudsNight:
            return "smoke.fill"
        case .showerRainNight:
            return "cloud.drizzle.fill"
        case .rainNight:
            return "cloud.rain.fill"
        case .thunderstormNight:
            return "cloud.moon.bolt.fill"
        case .snowNight:
            return "snow"
        case .mistNight:
            return "cloud.fog.fill"
        case .sunset:
            return "sunset.fill"
        case .sunrise:
            return "sunrise.fill"
        case .unknown:
            return "questionmark"
        }
    }
}
