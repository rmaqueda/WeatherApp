//
//  WeatherSetDataSourceInteractorTests.swift
//  WeatherAppUnitTests
//
//  Created by Ricardo Maqueda Martinez on 07/02/2021.
//

import XCTest
@testable import WeatherApp

final class WeatherSetDataSourceInteractorTests: XCTestCase {
    private var sut: WeatherSetDataSourceInteractor!
    private let spy = SpyWeatherRepositoryProtocol()
        
    override func setUp() {
        super.setUp()
        
        sut = WeatherSetDataSourceInteractor(repository: spy)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func test_changeDatasource_isCalled_as_default_value_API() {
        // given
        // when
        // then
        XCTAssertTrue(spy.check(method: .setDataSourceType(type: .api), predicate: CallstackMatcher.times(1)))
    }
    
    func test_changeDatasourceCalled_forCache_repository_called_forCahce() {
        // given
        // when
        sut.changeDataSource(isCacheEnabled: true)
        
        // then
        XCTAssertTrue(spy.check(method: .setDataSourceType(type: .cache), predicate: CallstackMatcher.times(1)))
    }
    
    func test_changeDatasourceCalled_forAPI_repository_called_forAPI_twice() {
        // given
        // when
        sut.changeDataSource(isCacheEnabled: false)
        
        // then
        XCTAssertTrue(spy.check(method: .setDataSourceType(type: .api), predicate: CallstackMatcher.times(2)))
    }
    
}
