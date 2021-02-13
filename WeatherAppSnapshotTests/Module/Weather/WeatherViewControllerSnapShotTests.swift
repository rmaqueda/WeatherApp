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
  
    func test_happypath() throws {
        isRecording = false
        
        // given
        let mock = OpenWeatherResponse.mockMadrid
        let mockMapped = WeatherViewModelMapper().map(for: mock)
        spy.dataSource = mockMapped
        let nav = UINavigationController(rootViewController: sut)
        
        // when

        // then
        assertSnapshot(matching: nav, as: .image)
        assertSnapshot(matching: nav, as: .recursiveDescription)
    }
            
}
