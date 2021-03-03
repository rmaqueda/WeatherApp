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

struct CitySearchViewModel: CitySearchViewModelProtocol {
    let wireframe: Wireframe
        
    func presentForecast(for city: City) {
        wireframe.presentForecast(for: city)
    }
    
}
