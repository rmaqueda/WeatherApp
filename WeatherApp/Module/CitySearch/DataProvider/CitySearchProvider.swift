//
//  CitySearchProvider.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 25/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation
import Combine

class CitySearchProvider: CitySearchProviderProtocol {
    private let wireframe: Wireframe
    
    init(wireframe: Wireframe) {
        self.wireframe = wireframe
    }
    
}
