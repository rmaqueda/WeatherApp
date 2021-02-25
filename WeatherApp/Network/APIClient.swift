//
//  APIClient.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//
// Based on: https://github.com/gonzalezreal/SimpleNetworking

import Combine
import Foundation

struct APIClientConfiguration {
    var additionalHeaders: [HeaderField: String]
    var additionalParameters: [String: CustomStringConvertible]
    
    init(additionalHeaders: [HeaderField: String] = [:], additionalParameters: [String: CustomStringConvertible] = [:]) {
        self.additionalHeaders = additionalHeaders
        self.additionalParameters = additionalParameters
    }
}

protocol APIClientProtocol {
    func response<Output, Error>(for apiRequest: APIRequest<Output, Error>) -> AnyPublisher<Output, APIClientError<Error>>
}

class APIClient: APIClientProtocol {
    let baseURL: URL
    let configuration: APIClientConfiguration
    private let session: URLSession
    
    init(baseURL: URL,
         configuration: APIClientConfiguration = APIClientConfiguration(),
         session: URLSession = URLSession(configuration: .default)) {
        self.baseURL = baseURL
        self.configuration = configuration
        self.session = session
    }
    
    func response<Output, Error>(for apiRequest: APIRequest<Output, Error>) -> AnyPublisher<Output, APIClientError<Error>> {
        let urlRequest = URLRequest(baseURL: baseURL, apiRequest: apiRequest)
            .addingHeaders(configuration.additionalHeaders)
            .addingParameters(configuration.additionalParameters)
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                // swiftlint:disable force_cast
                let httpResponse = response as! HTTPURLResponse
                // swiftlint:enable force_cast
                
                guard 200 ..< 300 ~= httpResponse.statusCode else {
                    let error = data.isEmpty ? nil : try apiRequest.error(data)
                    throw APIError(statusCode: httpResponse.statusCode, error: error)
                }
                
                return try apiRequest.output(data)
            }
            .mapError(APIClientError.init)
            .eraseToAnyPublisher()
    }
}

extension APIClient {

    convenience init(session: URLSession = URLSession.shared) {
        let parameters =  ["appid": ApplicationPreferences.openWeatherAPIKey,
                           "units": ApplicationPreferences.openWeatherAPIUnit,
                           "lang": ApplicationPreferences.language]

        let configuration = APIClientConfiguration(additionalParameters: parameters)

        self.init(baseURL: ApplicationPreferences.openWeatherAPIURL,
                  configuration: configuration,
                  session: session)
    }

}
