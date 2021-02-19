//
//  APIClient.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

extension APIRequest where Output: Decodable, Error: Decodable {

    static func get(_ path: String,
                    headers: [HeaderField: String] = [:],
                    parameters: [String: CustomStringConvertible] = [:],
                    jsonDecoder: JSONDecoder = JSONDecoder.openWeatherDecoder) -> APIRequest {
        
        APIRequest(method: .get,
                   path: path,
                   headers: [.accept: ContentType.json].merging(headers) { _, new in new },
                   parameters: parameters,
                   body: nil,
                   output: { try jsonDecoder.decode(Output.self, from: $0) },
                   error: { try jsonDecoder.decode(Error.self, from: $0) })
    }

}
