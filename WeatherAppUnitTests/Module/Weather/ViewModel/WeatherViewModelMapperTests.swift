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
        let viewDataModel = sut.map(city: City.mockMadrid, with: response)
        
        // then
        XCTAssertNotNil(viewDataModel)
        XCTAssertEqual(viewDataModel.sections.count, 3)
        
        if case let .city(info: city) = viewDataModel.sections[0] {
            XCTAssertEqual(city.name, "Madrid")
            XCTAssertEqual(city.currentWeatherText, "Overcast clouds")
        } else {
            XCTFail("Index 0 should be a city")
        }
        
        if case let .temperature(info: temperature) = viewDataModel.sections[1] {
            XCTAssertEqual(temperature.current, NumberFormatter.temperatureString(celsius: response.current.temp, unit: .celsius))
            XCTAssertEqual(temperature.highLow, "H: 12°  L: 8°")
        } else {
            XCTFail("Index 1 should be a forecast")
        }
        
        if case let .dailyForecast(info: dailyForecast) = viewDataModel.sections[2] {
            XCTAssertEqual(dailyForecast.count, 24)
            
            let firstForecast = dailyForecast[0]
            let firstElement = response.hourly[0]
            
            XCTAssertEqual(firstForecast.date.description, firstElement.date.description)
            XCTAssertEqual(firstForecast.title, "08")
            XCTAssertEqual(firstForecast.subTitle, "9°")
            XCTAssertEqual(firstForecast.probabilityPrecipitation, NumberFormatter.percentage.string(from: firstElement.pop))
            XCTAssertEqual(firstForecast.icon, .brokenCloudsNight)
        } else {
            XCTFail("Index 2 should be a daily forecast")
        }
        
    }
    
}
