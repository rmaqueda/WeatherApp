// Generated using Sourcery 0.18.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable all
import Foundation
import Combine
@testable import WeatherApp









// Spy for WeatherProviderProtocol
public class SpyWeatherProviderProtocol: WeatherProviderProtocol, TestSpy {
	public enum Method: Equatable {
        case requestForecast(city: String)
	}


    public var callstack = CallstackContainer<Method>()

    public init() {}

    public var requestForecastResult: AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>>!
    public func requestForecast(city: String) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>> {
        callstack.record(.requestForecast(city: city ))
        return requestForecastResult
    }
}
// Spy for WeatherRepositoryProtocol
public class SpyWeatherRepositoryProtocol: WeatherRepositoryProtocol, TestSpy {
	public enum Method: Equatable {
        case requestForecast(city: String)
        case setDataSourceType(type: AplicationPreferences.DataSourceType)
	}


    public var callstack = CallstackContainer<Method>()

    public init() {}

    public var requestForecastResult: AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>>!
    public func requestForecast(city: String) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>> {
        callstack.record(.requestForecast(city: city ))
        return requestForecastResult
    }
    public func setDataSourceType(_ type: AplicationPreferences.DataSourceType) {
        callstack.record(.setDataSourceType(type: type ))
    }
}
// Spy for WeatherRequestInteractorProtocol
public class SpyWeatherRequestInteractorProtocol: WeatherRequestInteractorProtocol, TestSpy {
	public enum Method: Equatable {
        case requestForecast(city: String?)
	}


    public var callstack = CallstackContainer<Method>()

    public init() {}

    public var requestForecastResult: AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>>!
    public func requestForecast(for city: String?) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>> {
        callstack.record(.requestForecast(city: city ))
        return requestForecastResult
    }
}
// Spy for WeatherSetDataSourceInteractorProtocol
public class SpyWeatherSetDataSourceInteractorProtocol: WeatherSetDataSourceInteractorProtocol, TestSpy {
	public enum Method: Equatable {
        case changeDataSource(isCacheEnabled: Bool)
	}


    public var callstack = CallstackContainer<Method>()

    public init() {}

    public func changeDataSource(isCacheEnabled: Bool) {
        callstack.record(.changeDataSource(isCacheEnabled: isCacheEnabled ))
    }
}
