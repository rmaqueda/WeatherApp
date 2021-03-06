//
//  UITestTag.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import Foundation

#if DEBUG
let uiTestEnvironmentKey = "UITestTag"

enum UITestTag: String {
    case weatherHappyPath
    case weatherErrorPath
}
#endif
