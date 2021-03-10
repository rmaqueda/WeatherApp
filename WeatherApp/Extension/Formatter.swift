//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//  Copyright © 2018 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let hour: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        
        return formatter
    }()

    static let time: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        return formatter
    }()
    
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        
        return formatter
    }()

}

extension NumberFormatter {

    static let oneDecimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1

        return formatter
    }()
    
    static let noDecimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        return formatter
    }()
    
    static let percentage: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        
        return formatter
    }()
    
    func string(from number: Double) -> String? {
        self.string(from: number as NSNumber)
    }
    
    static func temperatureString(celsius: Double?, unit: TemperatureUnit = .celsius) -> String {
        guard let value = celsius else {
            return "--"
        }
        switch unit {
        case .celsius:
            return celsiusString(celsius: value)
        case .fahrenheit:
            return fahrenheitString(celsius: value)
        }
    }
    
    static func celsiusString(celsius: Double) -> String {
        let formatter = NumberFormatter.noDecimal
        guard let string = formatter.string(from: celsius) else {
            return "--"
        }
        
        return string + "°"
    }
    
    static func fahrenheitString(celsius: Double) -> String {
        let formatter = NumberFormatter.noDecimal
        let measure = Measurement(value: celsius, unit: UnitTemperature.celsius)
        let fahrenheit = measure.converted(to: .fahrenheit).value
        guard let string = formatter.string(from: fahrenheit) else {
            return "--"
        }
        
        return string + "°"
    }
    
}
