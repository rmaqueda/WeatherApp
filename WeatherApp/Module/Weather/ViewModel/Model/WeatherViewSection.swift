//
//  WeatherViewSection.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation
import UIKit

enum WeatherViewSection {
    case city(info: WeatherViewModelData.City)
    case temperature(info: WeatherViewModelData.Temperature)
    case dailyForecast(info: [WeatherViewModelData.HourCondition])
    case activityIndicator
    
    var cellClass: ReusableView.Type {
        switch self {
        case .city:
            return CityCollectionViewCell.self
        case .temperature:
            return TemperatureCollectionViewCell.self
        case .dailyForecast:
            return HourForecastCollectionViewCell.self
        case .activityIndicator:
            return ActivityIndicatorCollectionViewCell.self
        }
    }
    
    var numberOfItems: Int {
        switch self {
        case .city:
            return 1
        case .temperature:
            return 1
        case .dailyForecast:
            return 24
        case .activityIndicator:
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
            return CGSize(width: 50, height: 100)
        case .activityIndicator:
            return CGSize(width: 200, height: 300)
        }
    }

}
