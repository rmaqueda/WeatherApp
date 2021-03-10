//
//  WeatherModuleIntegrationTests.swift
//  WeatherAppIntegrationTests
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherModuleIntegrationTests: XCTestCase {
    private var sut: WeatherViewModel!
    private var cancellables = Set<AnyCancellable>()
        
    override func setUp() {
        super.setUp()
        
        let apiClient = APIClient(session: .stubbed)
        let userPreferences = UserPreferencesDisk()
        let provider = WeatherProvider(apiClient: apiClient, userPreferences: userPreferences)
        sut = WeatherViewModel(city: City.mockMadrid,
                               provider: provider,
                               mapper: WeatherViewModelMapper(),
                               userPreferences: userPreferences,
                               wireframe: SpyWireframeProtocol())
    }
    
    override func tearDown() {
        HTTPStubProtocol.removeAllStubs()
        sut = nil
        
        super.tearDown()
    }
    
    func test_givenResponseSuccess_whenRequestForecast_thenReceiveExpectedForecastSections() throws {
        // given
        try HTTPStubProtocol.stubForecastRequest()
        let didReceiveActivityIndicator = expectation(description: "didReceiveValue")
        let didReceiveSections = expectation(description: "didReceiveValue")
        var expectedSections: [WeatherViewSectionData]?
        
        // when
        sut.requestForecast()
        
        sut.dataSourcePublisher
            .receive(on: DispatchQueue.main)
            .sink { response in
                let sections = response.sections
                
                if let firstSection = sections.first,
                   case WeatherViewSectionData.activityIndicator = firstSection {
                    didReceiveActivityIndicator.fulfill()
                } else {
                    expectedSections = sections
                    didReceiveSections.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [didReceiveActivityIndicator, didReceiveSections], timeout: 1)
        
        // then
        XCTAssertEqual(expectedSections?.count, 3)
    }
    
    func test_givenResponseError_whenRequestForecast_thenReceiveError() throws {
        // given
        try HTTPStubProtocol.stubForecastRequestError()
        
        let didReceiveActivityIndicator = expectation(description: "didReceiveValue")
        let didReceiveResponse = expectation(description: "didReceiveValue")
        
        var expectedResponse: WeatherViewModelData?
        
        // when
        sut.requestForecast()
        
        sut.dataSourcePublisher
            .receive(on: DispatchQueue.main)
            .sink { response in
                if let firstSection = response.sections.first,
                   case WeatherViewSectionData.activityIndicator = firstSection {
                    didReceiveActivityIndicator.fulfill()
                } else {
                    expectedResponse = response
                    didReceiveResponse.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [didReceiveActivityIndicator, didReceiveResponse], timeout: 1)
        
        // then
        XCTAssertEqual(expectedResponse?.sections.count, 0)
        XCTAssertNotNil(expectedResponse?.error)
    }
    
}
