//
//  String.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
}
