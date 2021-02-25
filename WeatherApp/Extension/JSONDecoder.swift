//
//  JSONDecoder.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import Foundation

extension JSONDecoder {
    
    static let openWeatherDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

    static func decode<T: Decodable>(jsonFile: String) -> T {
        guard let file = Bundle.main.url(forResource: jsonFile, withExtension: "") else {
            fatalError("File \(jsonFile) doesn't exit.")
        }
        
        guard let data = try? Data(contentsOf: file) else {
            fatalError("Error getting data from file \(jsonFile).")
        }
        do {
            return try JSONDecoder.openWeatherDecoder.decode(T.self, from: data)
        } catch {
            fatalError("Error decoding file \(jsonFile) for type \(T.self).")
        }
    }
    
}
