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
        let response = OpenWeatherResponse.mockMadrid
        
        // when
        let viewDataModel = sut.map(for: City.mockMadrid, with: response)
        
        // then
        XCTAssertNotNil(viewDataModel)
        XCTAssertEqual(viewDataModel.sections.count, 3)
        
        if case let .city(info: city) = viewDataModel.sections[0] {
            XCTAssertEqual(city.name, "Madrid")
            XCTAssertEqual(city.curretWeatherText, "overcast clouds")
        } else {
            XCTFail("Index 0 should be a city")
        }
        
        if case let .temperature(info: temperature) = viewDataModel.sections[1] {
            XCTAssertEqual(temperature.current, MeasurementFormatter.string(from: response.daily.first?.temp.eve))
            XCTAssertEqual(temperature.high, MeasurementFormatter.string(from: response.daily.first?.temp.max))
            XCTAssertEqual(temperature.low, MeasurementFormatter.string(from: response.daily.first?.temp.min))
        } else {
            XCTFail("Index 1 should be a city")
        }
        
        if case let .dailyForecast(info: dailyForecast) = viewDataModel.sections[2] {
            XCTAssertEqual(dailyForecast.count, 48)
            
            let firstForecast = dailyForecast[0]
            let firstElement = response.hourly[0]
            
            XCTAssertEqual(firstForecast.date.description, firstElement.dt.description)
            XCTAssertEqual(firstForecast.title, MeasurementFormatter.string(from: firstElement.temp))
            XCTAssertEqual(firstForecast.subTitle, DateFormatter.time.string(from: firstElement.dt))
            XCTAssertEqual(firstForecast.probabilityPrecipitation, NumberFormatter.percentage.string(from: firstElement.pop))
            XCTAssertEqual(firstForecast.icon, .brokenCloudsNight)
        } else {
            XCTFail("Index 2 should be a daily forecast")
        }
        
    }
    
}
