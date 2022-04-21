//
//  ForecastViewModelMapper.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import Foundation

struct WeatherViewModelMapper {
    
    func map(city: City, with response: OpenWeatherResponse, temperatureUnit: TemperatureUnit = .celsius) -> WeatherViewModelData {
        let city = WeatherViewModelData.City(
            name: city.name,
            currentWeatherText: response.current.weather.first?.weatherDescription.capitalizingFirstLetter()
        )
        
        let hourlyLimited = response.hourly.prefix(24)
        let hourly = hourlyLimited.map {
            WeatherViewModelData.HourCondition(
                date: $0.date,
                title: DateFormatter.hour.string(from: $0.date),
                subTitle: NumberFormatter.temperatureString(celsius: $0.temp, unit: temperatureUnit),
                probabilityPrecipitation: $0.pop > 0.30 ? NumberFormatter.percentage.string(from: $0.pop) : nil,
                icon: ForecastIcon(rawValue: $0.weather.first?.icon ?? "") ?? .unknown
            )
        }
        
        let temperature = NumberFormatter.temperatureString(celsius: response.current.temp, unit: temperatureUnit)
        let temperatureMax = NumberFormatter.temperatureString(celsius: response.daily.first?.temp.max, unit: temperatureUnit)
        let temperatureMin = NumberFormatter.temperatureString(celsius: response.daily.first?.temp.min, unit: temperatureUnit)
        let temperatureData = WeatherViewModelData.Temperature(current: temperature, highLow: "H: \(temperatureMax)  L: \(temperatureMin)")
        
        return WeatherViewModelData(
            sections: [
                .city(info: city),
                .temperature(info: temperatureData),
                .dailyForecast(info: hourly)
            ]
        )
    }
    
}
