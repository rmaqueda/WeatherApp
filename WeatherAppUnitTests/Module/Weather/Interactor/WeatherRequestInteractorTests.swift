//
//  WeatherRequestInteractorTests.swift
//  WeatherAppUnitTests
//
//  Created by Ricardo Maqueda Martinez on 07/02/2021.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherRequestInteractorTests: XCTestCase {
    private var sut: WeatherRequestInteractor!
    
    private let preferences = AplicationPreferences()
    private let spy = SpyWeatherRepositoryProtocol()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        sut = WeatherRequestInteractor(preferences: preferences, repository: spy)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func test_givenACity_whenRequestForecast_thenRequestForecastForCity() {
        // given
        let didReceiveValue = expectation(description: "didReceiveValue")
        spy.requestForecastResult = Empty().eraseToAnyPublisher()
        
        // when
        sut.requestForecast(for: "London")
            .sink(receiveCompletion: { _ in
                didReceiveValue.fulfill()
            }) { _ in }
            .store(in: &cancellables)

        wait(for: [didReceiveValue], timeout: 1)
        
        // then
        XCTAssertTrue(spy.check(method: .requestForecast(city: "London"), predicate: CallstackMatcher.times(1)))
    }
    
    func test_givenNilCity_whenRequestForecast_thenRequestForecastForDefaultCity() {
        // given
        let didReceiveValue = expectation(description: "didReceiveValue")
        spy.requestForecastResult = Empty().eraseToAnyPublisher()
        
        // when
        sut.requestForecast(for: nil)
            .sink(receiveCompletion: { _ in
                didReceiveValue.fulfill()
            }) { _ in }
            .store(in: &cancellables)
        
        wait(for: [didReceiveValue], timeout: 1)
        
        // then
        XCTAssertTrue(spy.check(method: .requestForecast(city: "Munich"), predicate: CallstackMatcher.times(1)))
    }

}
