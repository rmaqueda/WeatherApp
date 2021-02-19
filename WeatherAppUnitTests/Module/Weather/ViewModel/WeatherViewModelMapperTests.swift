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
        let responseMock = OpenWeatherResponse.mockLondon
        
        // when
        let viewModelMock = sut.map(for: responseMock)
        
        // then
        XCTAssertNotNil(viewModelMock)
        XCTAssertEqual(viewModelMock.sections.count, 3)
        
        if case let .city(info: city) = viewModelMock.sections[0] {
            XCTAssertEqual(city.name, "London")
            XCTAssertEqual(city.curretWeatherText, "light rain")
        } else {
            XCTFail("Index 0 should be a city")
        }
        
        if case let .temperature(info: temperature) = viewModelMock.sections[1] {
            XCTAssertEqual(temperature.current, MeasurementFormatter.string(from: responseMock.list.first?.main.temperature))
            XCTAssertEqual(temperature.high, MeasurementFormatter.string(from: responseMock.list.first?.main.temperatureMax))
            XCTAssertEqual(temperature.low, MeasurementFormatter.string(from: responseMock.list.first?.main.temperatureMin))
        } else {
            XCTFail("Index 1 should be a city")
        }
        
        if case let .dailyForecast(info: dailyForecast) = viewModelMock.sections[2] {
            XCTAssertTrue(dailyForecast.count == 40)
            
            let firstForecast = dailyForecast[0]
            let firstElementMock = responseMock.list[0]
            
            XCTAssertEqual(firstForecast.date.description, firstElementMock.date.description)
            XCTAssertEqual(firstForecast.title, MeasurementFormatter.string(from: firstElementMock.main.temperature))
            XCTAssertEqual(firstForecast.subTitle, DateFormatter.time.string(from: firstElementMock.date))
            XCTAssertEqual(firstForecast.dateString, DateFormatter.date.string(from: firstElementMock.date))
            XCTAssertEqual(firstForecast.icon, .rain)
        } else {
            XCTFail("Index 2 should be a daily forecast")
        }

    }

}
