//
//  APIRequestTests.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import XCTest
@testable import WeatherApp

final class APIRequestTests: XCTestCase {
    let aURL = URL(string: "http://stub.com")!
    let path = "/path"
    lazy var aURLWithPath = aURL.appendingPathComponent(path)
    
    func test_givenAURLPath_whenCreateRequest_thenRequestHasConfiguredURLPath() {
        // given
        let expectedRequest = request(with: "appid=value")
        
        // when
        let request = APIRequest<String, TestError>.get(path,
                                                        parameters: ["appid": "value"],
                                                        jsonDecoder: JSONDecoder.openWeatherDecoder)
        let result = URLRequest(baseURL: aURL, apiRequest: request)
        
        // then
        XCTAssertEqual(result, expectedRequest)
    }
    
    func test_givenAURLPath_andAParameter_whenCreateRequest_thenRequestHasConfiguredParameter() {
        // given
        let expectedRequest = request(with: "lang=en")
        
        // when
        let request = APIRequest<String, TestError>.get(path, jsonDecoder: JSONDecoder.openWeatherDecoder)
        let result = URLRequest(baseURL: aURL, apiRequest: request).addingParameters(["lang": "en"])
        
        // then
        XCTAssertEqual(result, expectedRequest)
    }
    
    func test_givenAURLPath_andHeaders_whenCreateRequest_thenRequestHasConfiguredHeaders() {
        // given
        let expectedRequest = URLRequest(url: aURLWithPath)
            .addingHeaders([.authorization: "Bearer stub"])
            .addingHeaders([.accept: "application/json"])
        
        // when
        let request = APIRequest<String, TestError>.get(path, jsonDecoder: JSONDecoder.openWeatherDecoder)
        let result = URLRequest(baseURL: aURL, apiRequest: request).addingHeaders([.authorization: "Bearer stub"])
        
        // then
        XCTAssertEqual(result, expectedRequest)
    }

    private func request(with parameter: String) -> URLRequest {
        var components = URLComponents(url: aURLWithPath, resolvingAgainstBaseURL: false)!
        components.query = parameter
        
        let request = URLRequest(url: components.url!)
            .addingHeaders([.accept: "application/json"])
        
        return request
    }
    
}
