//
//  OpenWeatherOneCall.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 22/02/2021.
//
// This structs are generated automatically with https://app.quicktype.io
import Foundation

// MARK: - OpenWeatherAPIError
struct OpenWeatherAPIError: Error, Codable {
    let cod: String
    let message: String
}

// MARK: - OneCall
struct OpenWeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let alerts: [Alert]?
    let minutely: [Minutely]
    let hourly: [Hourly]
    let daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case timezone = "timezone"
        case timezoneOffset = "timezone_offset"
        case current = "current"
        case alerts = "alerts"
        case minutely = "minutely"
        case hourly = "hourly"
        case daily = "daily"
    }
}

// MARK: - Alert
struct Alert: Codable {
    let senderName: String
    let event: String
    let start: Int
    let end: Int
    let alertDescription: String
    
    enum CodingKeys: String, CodingKey {
        case senderName = "sender_name"
        case event = "event"
        case start = "start"
        case end = "end"
        case alertDescription = "description"
    }
}

// MARK: - Current
struct Current: Codable {
    let date: Date
    let sunrise: Date
    let sunset: Date
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case uvi = "uvi"
        case clouds = "clouds"
        case visibility = "visibility"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather = "weather"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case weatherDescription = "description"
        case icon = "icon"
    }
}

// MARK: - Daily
struct Daily: Codable {
    let date: Date
    let sunrise: Date
    let sunset: Date
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather = "weather"
        case clouds = "clouds"
        case pop = "pop"
        case rain = "rain"
        case uvi = "uvi"
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let evening: Double
    let morning: Double
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case night = "night"
        case evening = "eve"
        case morning = "morn"
    }
}

// MARK: - Temp
struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let evening: Double
    let morning: Double
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case min = "min"
        case max = "max"
        case night = "night"
        case evening = "eve"
        case morning = "morn"
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let date: Date
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let pop: Double
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case uvi = "uvi"
        case clouds = "clouds"
        case visibility = "visibility"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather = "weather"
        case pop = "pop"
        case rain = "rain"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Minutely
struct Minutely: Codable {
    let date: Date
    let precipitation: Double
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case precipitation = "precipitation"
    }
}
