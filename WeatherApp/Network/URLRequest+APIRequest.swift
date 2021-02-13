//
//  URLRequest+APIRequest.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

extension URLRequest {
 
    init<Output, Error>(baseURL: URL, apiRequest: APIRequest<Output, Error>) {
        let url = baseURL.appendingPathComponent(apiRequest.path)

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!

        if !apiRequest.parameters.isEmpty {
            components.queryItems = apiRequest.parameters.sorted { $0.key < $1.key }.map { name, value in
                URLQueryItem(name: name, value: value.description)
            }
        }

        self.init(url: components.url!)

        httpMethod = apiRequest.method.rawValue
        httpBody = apiRequest.body

        for (field, value) in apiRequest.headers {
            addValue(value.description, forHTTPHeaderField: field.rawValue)
        }
    }

    func addingParameters(_ parameters: [String: CustomStringConvertible]) -> URLRequest {
        guard !parameters.isEmpty else { return self }

        var components = URLComponents(url: url!, resolvingAgainstBaseURL: false)!

        let queryItems = (components.queryItems ?? []) + parameters.map { name, value in
            URLQueryItem(name: name, value: value.description)
        }

        components.queryItems = queryItems.sorted { $0.name < $1.name }

        var result = self
        result.url = components.url

        return result
    }

    func addingHeaders(_ headers: [HeaderField: String]) -> URLRequest {
        guard !headers.isEmpty else { return self }

        var result = self

        for (field, value) in headers {
            result.addValue(value, forHTTPHeaderField: field.rawValue)
        }

        return result
    }
}
