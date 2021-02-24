//
//  HeaderField.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

struct HeaderField: Hashable, Equatable, RawRepresentable {
    let rawValue: String
}

extension HeaderField {
    static let acceptEncoding = HeaderField(rawValue: "Accept-Encoding")
    static let acceptLanguage = HeaderField(rawValue: "Accept-Language")
    static let accept = HeaderField(rawValue: "Accept")
    static let authorization = HeaderField(rawValue: "Authorization")
    static let contentType = HeaderField(rawValue: "Content-Type")
}
