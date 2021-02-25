//
//  CitySearchViewModel.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 25/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation
import UIKit
import Combine

class CitySearchViewModel: CitySearchViewModelProtocol, ObservableObject {
    private let provider: CitySearchProviderProtocol
    private let wireframe: Wireframe
    
    required init(provider: CitySearchProviderProtocol, wireframe: Wireframe) {
        self.provider = provider
        self.wireframe = wireframe
    }
    
    func presentForecast(for city: City) {
        wireframe.presentForecast(for: city)
    }
    
}
