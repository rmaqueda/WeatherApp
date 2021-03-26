//
//  WeatherViewControllerSnapShotTests.swift
//  WeatherAppUITests
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

@testable import WeatherApp
import SnapshotTesting
import XCTest
import Combine

final class WeatherViewControllerSnapShotTests: XCTestCase {
    var sut: WeatherViewController!
    let spy = SpyWeatherViewModelProtocol()
    var nav: UINavigationController!
    @Published var publisher: WeatherViewModelData = WeatherViewModelData.activityIndicator()
    
    override func setUp() {
        super.setUp()
        
        let mock = OpenWeatherResponse.mockMadrid
        let mockMapped = WeatherViewModelMapper().map(city: City.mockMadrid, with: mock)
        
        spy.dataSource = mockMapped
        spy.underlyingDataSource = mockMapped
        spy.underlyingDataSourcePublisher = $publisher
        spy.underlyingIsSaved = true
        
        sut = WeatherViewController(viewModel: spy)
        
        nav = UINavigationController(rootViewController: sut)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
  
    func test_weatherScreen_iPhoneSe() {
        assertSnapshot(matching: nav, as: .image(on: .iPhoneSe, precision: 0.8))
    }
    
    func test_weatherScreen_iPhoneXsMax() {
        assertSnapshot(matching: nav, as: .image(on: .iPhoneXsMax, precision: 0.8))
    }
    
    func test_weatherScreen_iPadPro12_9() {
        assertSnapshot(matching: nav, as: .image(on: .iPadPro12_9, precision: 0.8))
    }
    
    func test_weatherScreen_iPadMini() {
        assertSnapshot(matching: nav, as: .image(on: .iPadMini, precision: 0.8))
    }
            
}
