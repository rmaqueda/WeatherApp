//
//  CitySearchProtocols.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 25/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation
import MapKit

// sourcery: autoSpy
protocol CitySearchViewModelProtocol {
    var cities: [NSAttributedString] { get }
    var citiesPublisher: Published<[NSAttributedString]>.Publisher { get }
    
    func searchCities(searchText: String)
    func didSelectCity(at index: Int)
}

// sourcery: autoSpy
protocol CitySearchProviderProtocol {
    func searchCities(searchText: String, completionHandler: @escaping ([MKLocalSearchCompletion]) -> Void)
    func searchCity(at index: Int, completionHandler: @escaping (City) -> Void)
}
