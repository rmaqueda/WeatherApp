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

    private let requestForecastInteractorSpy = SpyWeatherRequestInteractorProtocol()
    private let setDataSourceInteractorSpy = SpyWeatherSetDataSourceInteractorProtocol()
    private let mapper = WeatherViewModelMapper()
    
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        
        sut = WeatherViewModel(requestForecastInteractor: requestForecastInteractorSpy,
                               setDataSourceInteractor: setDataSourceInteractorSpy,
                               mapper: mapper)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func test_givenDefaultForecastRequest_whenRequestForecast_thenReceiveExpectedResult() {
        // given
        let didReceiveValue = expectation(description: "didReceiveValue")
        var response: WeatherViewModelData?
        
        let mock = Just(OpenWeatherResponse.mockMadrid).setFailureType(to: APIClientError<OpenWeatherAPIError>.self).eraseToAnyPublisher()
        requestForecastInteractorSpy.requestForecastResult = mock
        
        // when
      
        sut.requestForecast(for: nil)

        sut.dataSourcePublisher
            .assertNoFailure()
            .sink { viewModel in
                response = viewModel
                didReceiveValue.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [didReceiveValue], timeout: 1)
        
        // then
        XCTAssertTrue(requestForecastInteractorSpy.check(method: .requestForecast(city: nil), predicate: CallstackMatcher.times(1)))
        
        XCTAssertNotNil(response?.sections)
        XCTAssertTrue(response?.sections.count == 3)
        XCTAssertNil(response?.error)
    }
    
    func test_givenCityForecastRequest_whenRequestForecast_thenReceiveExpectedCity() {
        // given
        let didReceiveValue = expectation(description: "didReceiveValue")
        var response: WeatherViewModelData?
        
        let mock = Just(OpenWeatherResponse.mockMadrid).setFailureType(to: APIClientError<OpenWeatherAPIError>.self).eraseToAnyPublisher()
        requestForecastInteractorSpy.requestForecastResult = mock
        
        // when
        sut.requestForecast(for: "stub")
        
        sut.dataSourcePublisher
            .assertNoFailure()
            .sink { viewModel in
                response = viewModel
                didReceiveValue.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [didReceiveValue], timeout: 1)
        
        // then
        XCTAssertTrue(requestForecastInteractorSpy.check(method: .requestForecast(city: "stub"), predicate: CallstackMatcher.times(1)))
        
        XCTAssertNotNil(response?.sections)
        XCTAssertTrue(response?.sections.count == 3)
        XCTAssertNil(response?.error)
    }
    
    func test_givenForecastRequestError_whenRequestForecast_thenReceiveError() {
        // given
        let didReceiveValue = expectation(description: "didReceiveValue")
        var response: WeatherViewModelData?
        
        let mockError = APIClientError.apiError(APIError(statusCode: 400, error: OpenWeatherAPIError(cod: "400", message: "stub")))
        requestForecastInteractorSpy.requestForecastResult = Fail(error: mockError).eraseToAnyPublisher()
        
        // when
        sut.requestForecast(for: "stub")
        
        sut.dataSourcePublisher
            .assertNoFailure()
            .sink { viewModel in
                response = viewModel
                didReceiveValue.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [didReceiveValue], timeout: 1)
        
        // then
        XCTAssertTrue(requestForecastInteractorSpy.check(method: .requestForecast(city: "stub"), predicate: CallstackMatcher.times(1)))
        
        XCTAssertNotNil(response?.error)
        XCTAssertTrue(response?.sections.count == 0)
    }
    
    func test_cacheSwitchDidChange_true_interactorCalled() {
        // given

        // when
        sut.cacheSwitchDidChange(isEnable: true)
        
        // then
        XCTAssertTrue(setDataSourceInteractorSpy.check(method: .changeDataSource(isCacheEnabled: true),
                                                       predicate: CallstackMatcher.times(1)))
    }
    
    func test_cacheSwitchDidChange_false_interactorCalled() {
        // given
        
        // when
        sut.cacheSwitchDidChange(isEnable: false)
        
        // then
        XCTAssertTrue(setDataSourceInteractorSpy.check(method: .changeDataSource(isCacheEnabled: false),
                                                       predicate: CallstackMatcher.times(1)))
    }
        
}
