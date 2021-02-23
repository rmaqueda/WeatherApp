//
//  ForecastViewModelMapper.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import Foundation

class WeatherViewModelMapper {
    
    func map(for city: City, with response: OpenWeatherResponse) -> WeatherViewModelData {
        let city = WeatherViewModelData.City(name: city.name,
                                             curretWeatherText: response.current.weather.first?.weatherDescription)
        
        let daily = response.hourly.map {
            WeatherViewModelData.HourCondition(date: $0.dt,
                                               title: MeasurementFormatter.string(from: $0.temp),
                                               subTitle: DateFormatter.time.string(from: $0.dt),
                                               probabilityPrecipitation: $0.pop > 0.30 ? NumberFormatter.percentage.string(from: $0.pop) : nil,
                                               icon: ForecastIcon(rawValue: $0.weather.first?.icon ?? "") ?? .unknown
            )
        }
        
        let temperature = MeasurementFormatter.string(from: response.daily.first?.temp.eve)
        let temperatureMax = MeasurementFormatter.string(from: response.daily.first?.temp.max)
        let temperatureMin = MeasurementFormatter.string(from: response.daily.first?.temp.min)
        let temperatureData = WeatherViewModelData.Temprature(current: temperature,
                                                              high: temperatureMax,
                                                              low: temperatureMin)
        
        return WeatherViewModelData(
            sections: [.city(info: city), .temperature(info: temperatureData), .dailyForecast(info: daily)]
        )
    }
    
}
