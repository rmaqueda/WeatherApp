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
        checkElementsHappyPath()
    }
    
    func test_givenWeatherForecastRequestError_whenAppIsLaunched_thenShowExpectedError() throws {
        // given
        app.launchEnvironment = [UITestEnvironmentKey: UITestTag.weatherErrorPath.rawValue]
        
        // when
        app.launch()
        
        // then
        checkElementsUnHappyPath()
    }
      
    private func checkElementsHappyPath() {
        XCTAssertFalse(app.staticTexts["CityNameLabel"].label.isEmpty)
        XCTAssertFalse(app.staticTexts["ConditionsLabel"].label.isEmpty)
        
        XCTAssertFalse(app.staticTexts["TemperatureLabel"].label.isEmpty)
        XCTAssertFalse(app.staticTexts["HighLowTemperatureLabel"].label.isEmpty)

        // Scrool and check all the cells
        XCTAssertFalse(app.staticTexts["DailyForecastTitle_0"].label.isEmpty)
        if ProcessInfo().operatingSystemVersion.majorVersion == 14 {
            XCTAssertFalse(app.images["DailyForecastImageView_0"].label.isEmpty)
        }
        if ProcessInfo().operatingSystemVersion.majorVersion == 13 {
            XCTAssertFalse(app.images["DailyForecastImageView_0"].label.isEmpty)
        }
        XCTAssertFalse(app.staticTexts["DailyForecastPrecipitation_0"].label.isEmpty)
        XCTAssertFalse(app.staticTexts["DailyForecastSubtitle_0"].label.isEmpty)
    }
        
    private func checkElementsUnHappyPath() {
        XCTAssertEqual(app.alerts.element.label, "Oops")
        XCTAssert(app.alerts["Oops"].buttons["Retry"].exists)
        XCTAssert(app.alerts["Oops"].buttons["Cancel"].exists)
    }
    
}
