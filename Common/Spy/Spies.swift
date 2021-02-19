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

public class SpyWeatherViewModelProtocol: WeatherViewModelProtocol, TestSpy {
    public enum Method: Equatable {
        case requestForecast(city: String?)
        case cacheSwitchDidChange(isEnable: Bool)
    }

    @Published public var dataSource: WeatherViewModelData = WeatherViewModelData.activityIndicator()
    public var dataSourcePublished: Published<WeatherViewModelData> { _dataSource }
    public var dataSourcePublisher: Published<WeatherViewModelData>.Publisher { $dataSource }

    public var requestForecastResult: WeatherViewModelData?
    
    public var callstack = CallstackContainer<Method>()
    
    // MARK: WeatherViewModelProtocol
    
    public func requestForecast(for city: String?) {
        callstack.record(.requestForecast(city: city ))

        if let requestForecastResult = requestForecastResult {
            dataSource = requestForecastResult
        }
    }

    public func cacheSwitchDidChange(isEnable: Bool) {
        callstack.record(.cacheSwitchDidChange(isEnable: isEnable ))
    }
}
