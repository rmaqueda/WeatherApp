@testable import WeatherApp
import XCTest
import CoreLocation

final class OpenWeatherCityTests: XCTestCase {

    func test_coordenate() throws {
        let city = OpenWeatherCity(name: "stub",
                                   identifier: 0,
                                   population: 0,
                                   country: "stug",
                                   timeZone: 0,
                                   coordinate: OpenWeatherCity.Coordenate(lat: 100, lon: 100),
                                   sunrise: Date(),
                                   sunset: Date())
        
        XCTAssertEqual(city.CLLocationCoordinate2D.latitude, 100)
        XCTAssertEqual(city.CLLocationCoordinate2D.longitude, 100)
    }
}
