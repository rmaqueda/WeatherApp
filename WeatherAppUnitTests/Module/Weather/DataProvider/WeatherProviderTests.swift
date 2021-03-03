//
//  WeatherProviderTests.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherProviderTests: XCTestCase {
    private var sut: WeatherProvider!
    private var spy: APIClientSpy<OpenWeatherResponse>!

    private let url = URL(string: "http://stub.com")!
    private let response = OpenWeatherResponse.mockMadrid

    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()

        spy = APIClientSpy(baseURL: url)
        spy.response = response

        sut = WeatherProvider(apiClient: spy, storage: CityDiskStorage())
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func test_givenForecastRequest_whenPerformRequest_thenCallAPIClient() {
        // given
        let didReceiveValue = expectation(description: "didReceiveValue")
        var response: OpenWeatherResponse?

        let expectedAPIRequest: APIRequest<OpenWeatherResponse, TestError> = APIRequest.get("onecall",
                                                                                            parameters: ["lat": 0.0, "lon": 0.0],
                                                                                            jsonDecoder: JSONDecoder.openWeatherDecoder)
        let expectedRequest = URLRequest(baseURL: url, apiRequest: expectedAPIRequest)

        // when
        sut.forecast(for: City(name: "stub", coordinate: City.Coordinate(lat: 0, lon: 0), timeZone: nil, temperature: nil))
            .assertNoFailure()
            .sink(receiveValue: {
                response = $0
                didReceiveValue.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [didReceiveValue], timeout: 1)

        // then
        XCTAssertEqual(response?.lat, 51.5002)
        XCTAssertTrue(spy.check(method: .response(for: expectedRequest), predicate: CallstackMatcher.times(1)))
    }

}
