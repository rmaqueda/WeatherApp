//
//  WeatherViewDataModel.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

struct WeatherViewModelData {
    let sections: [WeatherViewSection]
    let error: APIClientError<OpenWeatherAPIError>?
    
    struct City {
        let name: String
        let currentWeatherText: String?
    }
    
    struct Temperature {
        let current: String
        let highLow: String
    }
    
    struct HourCondition {
        let date: Date
        let title: String
        let subTitle: String
        let probabilityPrecipitation: String?
        let icon: ForecastIcon?
    }
    
    init(sections: [WeatherViewSection]) {
        self.sections = sections
        self.error = nil
    }
    
    init(error: APIClientError<OpenWeatherAPIError>) {
        self.sections = []
        self.error = error
    }
    
    static func activityIndicator() -> WeatherViewModelData {
        WeatherViewModelData(sections: [.activityIndicator])
    }
    
}
