//
//  WeatherModuleUITests.swift
//  WeatherAppUITests
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import XCTest
import Foundation
@testable import WeatherApp

final class WeatherModuleUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()

        continueAfterFailure = true
    }

    func test_givenWeatherForecastRequestSuccess_whenAppIsLaunched_thenShowExpectedCity() throws {
        // given
        app.launchEnvironment = [UITestEnvironmentKey: UITestTag.weatherHappyPath.rawValue]
        
        // when
        app.launch()
        
        // then
        XCTAssertEqual(app.staticTexts["CacheLabel"].label, "Use cache")
        XCTAssertEqual(app.switches["CacheSwitch"].value as? String, "0")
        
        checkLondonWeatherScreen()
    }
    
    func test_givenWeatherForecastRequestError_whenAppIsLaunched_thenShowExpectedError() throws {
        // given
        app.launchEnvironment = [UITestEnvironmentKey: UITestTag.weatherErrorPath.rawValue]
        
        // when
        app.launch()
        
        // then
        XCTAssertEqual(app.alerts.element.label, "Oops")
        XCTAssert(app.alerts["Oops"].buttons["Retry"].exists)
        XCTAssert(app.alerts["Oops"].buttons["Cancel"].exists)
    }
    
    // This's a system test, could be better move to another target
    // and run just during regression.
    func test_givenAppLaunch_thenAppLoadDefaultCity_thenSwichAndLoadCacheCity() throws {
        // given
        app.launchEnvironment = [UITestEnvironmentKey: UITestTag.weatherHappyPath.rawValue]
        
        // when
        app.launch()
        
        // then
        XCTAssertEqual(app.staticTexts["CacheLabel"].label, "Use cache")
        XCTAssertEqual(app.switches["CacheSwitch"].value as? String, "0")
        checkLondonWeatherScreen()
        
        // when switch change
        let prefSwitch = app.switches["CacheSwitch"]
        prefSwitch.tap()
        
        XCTAssertEqual(app.staticTexts["CacheLabel"].label, "Use cache")
        XCTAssertEqual(app.switches["CacheSwitch"].value as? String, "1")
        
        checkMadridWeatherScreen()
    }
    
    private func checkLondonWeatherScreen() {
        XCTAssertEqual(app.staticTexts["CityNameLabel"].label, "London")
        XCTAssertEqual(app.staticTexts["ConditionsLabel"].label, "Light rain")
        
        XCTAssertEqual(app.staticTexts["TemperatureLabel"].label, "7.6°")
        XCTAssertEqual(app.staticTexts["HighLowTemperatureLabel"].label, "H: 7.6° L: 7.3°")
        
        // Scrool and check all the cells
        XCTAssertEqual(app.staticTexts["DailyForecastTitle_0"].label, "7.6°")
        XCTAssertEqual(app.images["DailyForecastImageView_0"].label, "rain")
        XCTAssertEqual(app.staticTexts["DailyForecastDate_0"].label, "07/02")
        XCTAssertEqual(app.staticTexts["DailyForecastSubtitle_0"].label, "15:00")
    }
    
    private func checkMadridWeatherScreen() {
        XCTAssertEqual(app.staticTexts["CityNameLabel"].label, "Madrid")
        XCTAssertEqual(app.staticTexts["ConditionsLabel"].label, "Light rain")
        
        XCTAssertEqual(app.staticTexts["TemperatureLabel"].label, "10.8°")
        XCTAssertEqual(app.staticTexts["HighLowTemperatureLabel"].label, "H: 10.9° L: 10.8°")
        
        // Scrool and check all the cells
        XCTAssertEqual(app.staticTexts["DailyForecastTitle_0"].label, "10.8°")
        XCTAssertEqual(app.images["DailyForecastImageView_0"].label, "rain")
        XCTAssertEqual(app.staticTexts["DailyForecastDate_0"].label, "07/02")
        XCTAssertEqual(app.staticTexts["DailyForecastSubtitle_0"].label, "15:00")
    }
    
}
