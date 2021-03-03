//
//  CitySearchProtocol.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 25/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation

// sourcery: autoSpy
protocol CitySearchViewModelProtocol {
    var wireframe: Wireframe { get }
    
    func presentForecast(for city: City)
}
