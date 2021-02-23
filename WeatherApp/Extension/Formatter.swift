//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//  Copyright © 2018 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation

extension DateFormatter {

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
}

extension MeasurementFormatter {
    
    static let temperature: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.numberFormatter = .oneDecimal
        
        return formatter
    }()
 
    static func string(from: Double?) -> String {
        guard let value = from else { return "-" }
        let formatter = MeasurementFormatter.temperature
        
        // FixBug Simulator and user temperature format
        // The Simulator doesn't respect the Temperature Unit setting, so force to work with celsius
        // https://openradar.appspot.com/radar?id=5042283099455488
        #if targetEnvironment(simulator)
            let measurement = Measurement(value: value, unit: UnitTemperature.fahrenheit)
        #else
            let measurement = Measurement(value: value, unit: UnitTemperature.celsius)
        #endif
        // end FixBug Simulator
        
        let temperature = formatter.string(from: measurement)
        
        return temperature
    }
}
