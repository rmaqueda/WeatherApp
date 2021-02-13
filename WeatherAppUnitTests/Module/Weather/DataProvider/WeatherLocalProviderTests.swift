@testable import WeatherApp
import XCTest
import Combine

final class WeatherLocalProviderTests: XCTestCase {
    private var sut: WeatherLocalProvider!
    
    private var cancellables = Set<AnyCancellable>()

    func test_givenForecastRequest_whenPerformRequest_thenMockIsTheResult() throws {
        // given
        sut = WeatherLocalProvider()
        let didReceiveData = expectation(description: "didReveiceData")
        var response: OpenWeatherResponse?
        
        // when
        sut.requestForecast(city: "stub")
            .sink(receiveCompletion: { _ in
                didReceiveData.fulfill()
            },
            receiveValue: { viewModel in
                response = viewModel
            })
            .store(in: &cancellables)
        
        wait(for: [didReceiveData], timeout: 1)
        
        // then
        XCTAssertEqual(response, OpenWeatherResponse.mockLondon)
    }
}
