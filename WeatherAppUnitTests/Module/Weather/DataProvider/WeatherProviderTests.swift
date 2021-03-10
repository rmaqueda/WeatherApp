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
    private let mock = OpenWeatherResponse.mockMadrid

    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()

        spy = APIClientSpy(baseURL: url)
        spy.response = mock

        sut = WeatherProvider(apiClient: spy, userPreferences: UserPreferencesDisk())
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
        sut.forecast(for: City.mockMadrid)
            .assertNoFailure()
            .sink(receiveValue: {
                response = $0
                didReceiveValue.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [didReceiveValue], timeout: 1)

        // then
        XCTAssertEqual(response?.latitude, 51.5002)
        XCTAssertTrue(spy.check(method: .response(for: expectedRequest), predicate: CallstackMatcher.times(1)))
    }

}
