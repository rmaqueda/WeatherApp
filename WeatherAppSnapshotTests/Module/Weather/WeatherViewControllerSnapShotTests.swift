@testable import WeatherApp
import SnapshotTesting
import XCTest
import Combine

final class WeatherViewControllerSnapShotTests: XCTestCase {
    var sut: WeatherViewController!
    let spy = SpyWeatherViewModelProtocol()
    
    override func setUp() {
        super.setUp()
        
        sut = WeatherViewController(viewModel: spy)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
  
    func test_weatherScreen_iPhone() {
        isRecording = false
        
        // given
        let mock = OpenWeatherResponse.mockMadrid
        let mockMapped = WeatherViewModelMapper().map(with: mock)
        spy.dataSource = mockMapped
        let nav = UINavigationController(rootViewController: sut)
        
        // when

        // then
        assertSnapshot(matching: nav, as: .image(on: .iPhoneSe, precision: 0.8))
        assertSnapshot(matching: nav, as: .image(on: .iPhoneXsMax, precision: 0.8))
    }
    
    func test_weatherScreen_iPad() {
        isRecording = false
        
        // given
        let mock = OpenWeatherResponse.mockLondon
        let mockMapped = WeatherViewModelMapper().map(with: mock)
        spy.dataSource = mockMapped
        let nav = UINavigationController(rootViewController: sut)
        
        // when
        
        // then
        assertSnapshot(matching: nav, as: .image(on: .iPadPro12_9, precision: 0.8))
        assertSnapshot(matching: nav, as: .image(on: .iPadMini, precision: 0.8))
    }
            
}
