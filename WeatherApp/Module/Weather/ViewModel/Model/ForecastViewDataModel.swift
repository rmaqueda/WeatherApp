//
//  WeatherViewDataModel.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

struct WeatherViewModelData {
    let sections: [WeatherViewSectionData]
    let error: APIClientError<OpenWeatherAPIError>?
    
    struct City {
        let name: String
        let curretWeatherText: String?
    }
    
    struct Temprature {
        let current: String
        let high: String
        let low: String
    }
    
    struct HourCondition {
        let date: Date
        let title: String
        let subTitle: String
        let dateString: String
        let icon: ForecastIcon?
    }
    
    init(sections: [WeatherViewSectionData]) {
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
