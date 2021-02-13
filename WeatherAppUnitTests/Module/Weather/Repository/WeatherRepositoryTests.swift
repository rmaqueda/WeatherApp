//
//  WeatherRepositoryTests.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherRepositoryTests: XCTestCase {
    private var sut: WeatherRepository!
    
    private var preferences = AplicationPreferences()
    private var APISpy = SpyWeatherProviderProtocol()
    private var localSpy = SpyWeatherProviderProtocol()
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        sut = WeatherRepository(APIProvider: APISpy, localProvider: localSpy)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func test_givenAPIInPreferences_whenRequestForecast_thenAPIProviderIsCalled() {
        // given
        sut.setDataSourceType(.api)
        
        let mock = Just(OpenWeatherResponse.mockMadrid).setFailureType(to: APIClientError<OpenWeatherAPIError>.self).eraseToAnyPublisher()
        APISpy.requestForecastResult = mock
        
        let didReceiveValue = expectation(description: "didReceiveValue")
        var response: OpenWeatherResponse?
        
        // when
        sut.requestForecast(city: "stub")
            .assertNoFailure()
            .sink(receiveValue: {
                response = $0
                didReceiveValue.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [didReceiveValue], timeout: 1)
        
        // then
        XCTAssertNotNil(response)
        XCTAssertTrue(APISpy.check(method: .requestForecast(city: "stub"), predicate: CallstackMatcher.times(1)))
        XCTAssertTrue(localSpy.check(method: .requestForecast(city: "stub"), predicate: CallstackMatcher.never))
    }
    
    func test_givenCacheInPreferences_whenRequestForecast_thenCacheProviderIsCalled() {
        // given
        sut.setDataSourceType(.cache)
        
        let mock = Just(OpenWeatherResponse.mockMadrid).setFailureType(to: APIClientError<OpenWeatherAPIError>.self).eraseToAnyPublisher()
        localSpy.requestForecastResult = mock
        
        let didReceiveValue = expectation(description: "didReceiveValue")
        var response: OpenWeatherResponse?
        
        // when
        sut.requestForecast(city: "stub")
            .assertNoFailure()
            .sink(receiveValue: {
                response = $0
                didReceiveValue.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [didReceiveValue], timeout: 1)
        
        // then
        XCTAssertNotNil(response)
        XCTAssertTrue(localSpy.check(method: .requestForecast(city: "stub"), predicate: CallstackMatcher.times(1)))
        XCTAssertTrue(APISpy.check(method: .requestForecast(city: "stub"), predicate: CallstackMatcher.never))
    }

}
