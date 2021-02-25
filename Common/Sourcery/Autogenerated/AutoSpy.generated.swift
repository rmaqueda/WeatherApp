// Generated using Sourcery 0.18.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable all
import Foundation
import Combine
@testable import WeatherApp

// MARK: Spy for WeatherProviderProtocol
public class SpyWeatherProviderProtocol: WeatherProviderProtocol, TestSpy {
	public enum Method: Equatable {
        case isSaved(city: City)
        case save(city: City)
        case forecast(city: City)
	}


    public var callstack = CallstackContainer<Method>()

    public init() {
        // Intentionally unimplemented
    }

    public var isSavedResult: Bool!
    public func isSaved(city: City) -> Bool {
        callstack.record(.isSaved(city: city ))
        return isSavedResult
    }
    public func save(city: City) throws {
        callstack.record(.save(city: city ))
    }
    public var forecastResult: AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>>!
    public func forecast(for city: City) -> AnyPublisher<OpenWeatherResponse, APIClientError<OpenWeatherAPIError>> {
        callstack.record(.forecast(city: city ))
        return forecastResult
    }
}

// MARK: Spy for WireframeProtocol
public class SpyWireframeProtocol: WireframeProtocol, TestSpy {
	public enum Method: Equatable {
        case presentMainScreen
        case presentCityList
        case presentCitySearch
        case presentForecast(city: City)
        case didPressCityListButton
	}


    public var callstack = CallstackContainer<Method>()

    public init() {
        // Intentionally unimplemented
    }

    public func presentMainScreen() {
        callstack.record(.presentMainScreen)
    }
    public func presentCityList() {
        callstack.record(.presentCityList)
    }
    public func presentCitySearch() {
        callstack.record(.presentCitySearch)
    }
    public func presentForecast(for city: City) {
        callstack.record(.presentForecast(city: city ))
    }
    public func didPressCityListButton() {
        callstack.record(.didPressCityListButton)
    }
}


