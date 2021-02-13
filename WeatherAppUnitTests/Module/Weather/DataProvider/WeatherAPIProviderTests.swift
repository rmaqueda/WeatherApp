//
//  WeatherAPIProviderTests.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherAPIProviderTests: XCTestCase {
    private var sut: WeatherAPIProvider!
    private var spy: APIClientSpy<OpenWeatherResponse>!
    
    private let URLStub = URL(string: "http://stub.com")!
    private let responseMock = OpenWeatherResponse.mockMadrid
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        spy = APIClientSpy(baseURL: URLStub)
        spy.response = responseMock

        sut = WeatherAPIProvider(APIClient: spy)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func test_givenForecastRequest_whenPerformRequest_thenCallAPIClient() {
        // given
        let didReceiveValue = expectation(description: "didReceiveValue")
        var response: OpenWeatherResponse?
        
        let expectedAPIRequest: APIRequest<OpenWeatherResponse, TestError> = APIRequest.get("forecast", parameters: ["q": "city"])
        let expectedRequest = URLRequest(baseURL: URLStub, apiRequest: expectedAPIRequest)
        
        // when
        sut.requestForecast(city: "city")
            .assertNoFailure()
            .sink(receiveValue: {
                response = $0
                didReceiveValue.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [didReceiveValue], timeout: 1)
        
        // then
        XCTAssertEqual(response?.city.identifier, responseMock.city.identifier)
        XCTAssertTrue(spy.check(method: .response(for: expectedRequest), predicate: CallstackMatcher.times(1)))
    }
    
}
