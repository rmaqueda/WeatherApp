//
//  JSONDecoder.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import Foundation

// swiftlint:disable force_try
extension JSONDecoder {
    
    static let openWeatherDecoder: JSONDecoder = {
        let docoder = JSONDecoder()
        docoder.dateDecodingStrategy = .secondsSince1970
        return docoder
    }()

    static func decode<T: Decodable>(json: String, type: T.Type) -> T {
        guard let URL = Bundle.main.url(forResource: json, withExtension: "") else {
            fatalError("File \(json) doesn't exit")
        }
        
        guard let data = try? Data(contentsOf: URL) else {
            fatalError("Error decoding file \(json) for type T")
        }
        
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
}
// swiftlint:enable force_try
