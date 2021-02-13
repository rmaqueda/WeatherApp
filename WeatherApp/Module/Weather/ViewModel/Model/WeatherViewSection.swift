//
//  WeatherViewSection.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation
import UIKit

enum WeatherViewSectionType: Int, CaseIterable {
    case city
    case temperature
    case dailyForecast
    case activityIndicator
    
    var numberOfItems: Int {
        switch self {
        case .dailyForecast:
            return 40
        default:
            return 1
        }
    }
    
    var size: CGSize {
        switch self {
        case .city:
            return CGSize(width: 200, height: 90)
        case .temperature:
            return CGSize(width: 200, height: 140)
        case .dailyForecast:
            return CGSize(width: 80, height: 100)
        case .activityIndicator:
            return CGSize(width: 200, height: 300)
        }
    }
    
    var reuseIdentifier: String {
        switch self {
        case .city:
            return "CityCollectionViewCell"
        case .temperature:
            return "TemperatureCollectionViewCell"
        case .dailyForecast:
            return "DailyForecastCollectionViewCell"
        case .activityIndicator:
            return "ActivityIndicatorCollectionViewCell"
        }
    }
}

enum WeatherViewSectionData {
    case city(info: WeatherViewModelData.City)
    case temperature(info: WeatherViewModelData.Temprature)
    case dailyForecast(info: [WeatherViewModelData.HourCondition])
    case activityIndicator
    
    var metadata: WeatherViewSectionType {
        switch self {
        case .city:
            return .city
        case .temperature:
            return .temperature
        case .dailyForecast:
            return .dailyForecast
        case .activityIndicator:
            return .activityIndicator
        }
    }

}
