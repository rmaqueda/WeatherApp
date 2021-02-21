//
//  ForecastViewModelMapper.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import Foundation

class WeatherViewModelMapper {
    
    func map(with response: OpenWeatherResponse) -> WeatherViewModelData {
        let city = WeatherViewModelData.City(name: response.city.name,
                                             curretWeatherText: response.list.first?.weather.first?.descriptionText)
        
        let daily = response.list.map {
            WeatherViewModelData.HourCondition(date: $0.date,
                                               title: MeasurementFormatter.string(from: $0.main.temperature),
                                               subTitle: DateFormatter.time.string(from: $0.date),
                                               dateString: DateFormatter.date.string(from: $0.date),
                                               icon: ForecastIcon(rawValue: $0.weather.first?.icon ?? "") ?? .unknown
            )
        }
        
        let temperature = MeasurementFormatter.string(from: response.list.first?.main.temperature)
        let temperatureMax = MeasurementFormatter.string(from: response.list.first?.main.temperatureMax)
        let temperatureMin = MeasurementFormatter.string(from: response.list.first?.main.temperatureMin)
        let temperatureData = WeatherViewModelData.Temprature(current: temperature, high: temperatureMax, low: temperatureMin)
        
        return WeatherViewModelData(
            sections: [.city(info: city), .temperature(info: temperatureData), .dailyForecast(info: daily)]
        )
    }
    
}
