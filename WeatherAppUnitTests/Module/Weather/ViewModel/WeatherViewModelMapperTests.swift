//
//  WeatherViewModelMapperTests.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import XCTest
@testable import WeatherApp

final class WeatherViewModelMapperTests: XCTestCase {
    private var sut: WeatherViewModelMapper!
    
    override func setUp() {
        super.setUp()
        
        sut = WeatherViewModelMapper()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func test_givenForecastSuccessResponse_whenMap_thenReturnExpectedViewDataModel() {
        // given
        let response = OpenWeatherResponse.mockLondon
        
        // when
        let viewModel = sut.map(for: response)
        
        // then
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.sections.count, 3)
        
        if case let .city(info: city) = viewModel.sections[0] {
            XCTAssertEqual(city.name, "London")
            XCTAssertEqual(city.curretWeatherText, "light rain")
        } else {
            XCTFail("Index 0 should be a city")
        }
        
        if case let .temperature(info: temperature) = viewModel.sections[1] {
            XCTAssertEqual(temperature.current, "7.6°")
            XCTAssertEqual(temperature.high, "7.6°")
            XCTAssertEqual(temperature.low, "7.3°")
        } else {
            XCTFail("Index 1 should be a city")
        }
        
        if case let .dailyForecast(info: dailyForecast) = viewModel.sections[2] {
            XCTAssertTrue(dailyForecast.count == 40)
            let forecast = dailyForecast[0]
            XCTAssertEqual(forecast.date.description, "2052-02-07 15:00:00 +0000")
            XCTAssertEqual(forecast.title, "7.6°")
            XCTAssertEqual(forecast.subTitle, "15:00")
            XCTAssertEqual(forecast.dateString, "07/02")
            XCTAssertEqual(forecast.icon, .rain)
            
            let forecast1 = dailyForecast[1]
            XCTAssertEqual(forecast1.icon, .rainNight)
            
            let forecast2 = dailyForecast[2]
            XCTAssertEqual(forecast2.icon, .rainNight)
        } else {
            XCTFail("Index 2 should be a daily forecast")
        }

    }

}
