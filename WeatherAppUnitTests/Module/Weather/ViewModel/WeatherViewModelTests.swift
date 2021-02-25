//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherViewModelTests: XCTestCase {
    private var sut: WeatherViewModel!
    private var spy: SpyWeatherProviderProtocol!
    
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        
        spy = SpyWeatherProviderProtocol()
        sut = WeatherViewModel(city: City.mockMadrid,
                               mapper: WeatherViewModelMapper(),
                               provider: spy,
                               wireframe: SpyWireframeProtocol())
    }
    
    override func tearDown() {
        spy = nil
        sut = nil
        
        super.tearDown()
    }
    
    func test_givenDefaultForecastRequest_whenRequestForecast_thenReceiveExpectedResult() {
        // given
        let didReceiveValue = expectation(description: "didReceiveValue")
        var response: WeatherViewModelData?
        
        let mock = Just(OpenWeatherResponse.mockMadrid).setFailureType(to: APIClientError<OpenWeatherAPIError>.self).eraseToAnyPublisher()
        spy.forecastResult = mock
        
        // when
        sut.requestForecast()

        sut.dataSourcePublisher
            .assertNoFailure()
            .sink { viewModel in
                response = viewModel
                didReceiveValue.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [didReceiveValue], timeout: 1)
        
        // then
        XCTAssertTrue(spy.check(method: .forecast(city: City.mockMadrid), predicate: CallstackMatcher.times(1)))
        
        XCTAssertNotNil(response?.sections)
        XCTAssertTrue(response?.sections.count == 3)
        XCTAssertNil(response?.error)
    }
    
    func test_givenForecastRequestError_whenRequestForecast_thenReceiveError() {
        // given
        let didReceiveValue = expectation(description: "didReceiveValue")
        var response: WeatherViewModelData?

        let mockError = APIClientError.apiError(APIError(statusCode: 400, error: OpenWeatherAPIError(cod: "400", message: "stub")))
        spy.forecastResult = Fail(error: mockError).eraseToAnyPublisher()

        // when
        sut.requestForecast()

        sut.dataSourcePublisher
            .assertNoFailure()
            .sink { viewModel in
                response = viewModel
                didReceiveValue.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [didReceiveValue], timeout: 1)

        // then
        XCTAssertTrue(spy.check(method: .forecast(city: City.mockMadrid), predicate: CallstackMatcher.times(1)))

        XCTAssertNotNil(response?.error)
        XCTAssertTrue(response?.sections.count == 0)
    }
    
}
