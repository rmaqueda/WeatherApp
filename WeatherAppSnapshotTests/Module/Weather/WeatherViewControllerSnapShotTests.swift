@testable import WeatherApp
import SnapshotTesting
import XCTest
import Combine

final class WeatherViewControllerSnapShotTests: XCTestCase {
    var sut: WeatherViewController!
    let spy = SpyWeatherViewModelProtocol()
    var nav: UINavigationController!
    
    override func setUp() {
        super.setUp()
        
        sut = WeatherViewController(viewModel: spy)
        
        let mock = OpenWeatherResponse.mockMadrid
        let mockMapped = WeatherViewModelMapper().map(for: City.mockMadrid, with: mock)
        spy.dataSource = mockMapped
        nav = UINavigationController(rootViewController: sut)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
  
    func test_weatherScreen_iPhoneSe() {
        isRecording = false
        assertSnapshot(matching: nav, as: .image(on: .iPhoneSe, precision: 0.8))
    }
    
    func test_weatherScreen_iPhoneXsMax() {
        isRecording = false
        assertSnapshot(matching: nav, as: .image(on: .iPhoneXsMax, precision: 0.8))
    }
    
    func test_weatherScreen_iPadPro12_9() {
        isRecording = false
        assertSnapshot(matching: nav, as: .image(on: .iPadPro12_9, precision: 0.8))
    }
    
    func test_weatherScreen_iPadMini() {
        isRecording = false
        assertSnapshot(matching: nav, as: .image(on: .iPadMini, precision: 0.8))
    }
            
}
