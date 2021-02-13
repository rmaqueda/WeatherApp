//
//  WeatherModuleIngrationTests.swift
//  WeatherAppIntegrationTests
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherModuleIngrationTests: XCTestCase {
    private var sut: WeatherViewModel!
    private var cancellables = Set<AnyCancellable>()
        
    override func setUp() {
        let preferences = AplicationPreferences()
        let client = APIClient(preferences: preferences, session: .stubbed)
        let APIProvider = WeatherAPIProvider(APIClient: client)
        let localProvider = WeatherLocalProvider()
        let repository = WeatherRepository(APIProvider: APIProvider, localProvider: localProvider)
        let mapper = WeatherViewModelMapper()
        
        let requestForecastInteractor = WeatherRequestInteractor(preferences: preferences, repository: repository)
        let setDataSourceInteractor = WeatherSetDataSourceInteractor(repository: repository)
        
        sut = WeatherViewModel(requestForecastInteractor: requestForecastInteractor,
                               setDataSourceInteractor: setDataSourceInteractor,
                               mapper: mapper)
        
        super.setUp()
    }
    
    override func tearDown() {
        HTTPStubProtocol.removeAllStubs()
        sut = nil
        
        super.tearDown()
    }
    
    func test_givenResponseSuccess_whenRequestForecast_thenReceiveExpectedForecastSections() throws {
        // given
        HTTPStubProtocol.stubForecastRequest()
        
        let didReceiveActivityIndicator = expectation(description: "didReceiveValue")
        let didReceiveSections = expectation(description: "didReceiveValue")
        
        var expectedSections: [WeatherViewSectionData]?
        
        // when
        sut.requestForecast(for: "Munich")
        
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
        HTTPStubProtocol.stubForecastRequestError()
        
        let didReceiveActivityIndicator = expectation(description: "didReceiveValue")
        let didReceiveResponse = expectation(description: "didReceiveValue")
        
        var expectedResponse: WeatherViewModelData?
        
        // when
        sut.requestForecast(for: "Munich")
        
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
