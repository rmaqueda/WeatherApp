//
//  ContentType.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

struct ContentType: Hashable, Equatable, RawRepresentable, CustomStringConvertible {
    let rawValue: String

    var description: String {
        rawValue
    }
}

extension ContentType {
    static let json = ContentType(rawValue: "application/json")
}
