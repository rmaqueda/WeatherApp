//
//  APIClientSpy.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import Foundation
import Combine
@testable import WeatherApp

class APIClientSpy<T>: APIClientProtocol, TestSpy {
    var configuration = APIClientConfiguration()
    var session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    var callstack = CallstackContainer<Method>()
    let baseURL: URL
    var response: T?
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    // MARK: TestSpy
    
    enum Method: Equatable {
        case response(for: URLRequest)
    }
    
    // MARK: APIClientProtocol
    
    func response<Output, Error>(for apiRequest: APIRequest<Output, Error>) -> AnyPublisher<Output, APIClientError<Error>> {
        
        let request = URLRequest(baseURL: baseURL, apiRequest: apiRequest)
        callstack.record(.response(for: request))
        
        if let response = response as? Output {
            return Just(response)
                .setFailureType(to: APIClientError.self)
                .eraseToAnyPublisher()

        }
        fatalError("Type mismatch")
    }
    
}
