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
        XCTAssertEqual(app.switches["CacheSwitch"].value as? String, "0")
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
    
    // This's a system test, could be better move to another target
    // and run just during regression.
    func test_givenAppLaunch_thenAppLoadDefaultCity_thenSwichAndLoadCacheCity() throws {
        // given
        app.launchEnvironment = [UITestEnvironmentKey: UITestTag.weatherHappyPath.rawValue]
        
        // when
        app.launch()
        
        // then
        XCTAssertEqual(app.switches["CacheSwitch"].value as? String, "0")
        checkElementsHappyPath()
        
        // when switch change
        let prefSwitch = app.switches["CacheSwitch"]
        prefSwitch.tap()
        sleep(1)
        XCTAssertEqual(app.switches["CacheSwitch"].value as? String, "1")
        
        checkElementsHappyPath()
    }
    
    private func checkElementsHappyPath() {
        XCTAssertEqual(app.staticTexts["CacheLabel"].label, "Use cache")
        
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
        XCTAssertFalse(app.staticTexts["DailyForecastDate_0"].label.isEmpty)
        XCTAssertFalse(app.staticTexts["DailyForecastSubtitle_0"].label.isEmpty)
    }
    
    private func checkElementsUnHappyPath() {
        XCTAssertEqual(app.alerts.element.label, "Oops")
        XCTAssert(app.alerts["Oops"].buttons["Retry"].exists)
        XCTAssert(app.alerts["Oops"].buttons["Cancel"].exists)
    }
    
}
