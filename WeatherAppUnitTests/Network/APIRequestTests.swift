//
//  APIRequestTests.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import XCTest
@testable import WeatherApp

final class APIRequestTests: XCTestCase {
    let aURL = URL(string: "http://example.com")!
    
    func test_givenAURLPath_whenCreateRequest_thenRequestHasConfiguredURLPath() {
        // given
        let URLWithPath = aURL.appendingPathComponent("/path")
        
        var components = URLComponents(url: URLWithPath, resolvingAgainstBaseURL: false)!
        components.query = "appid=value"
        
        var expected = URLRequest(url: components.url!)
        expected.addValue("application/json", forHTTPHeaderField: "Accept")
        expected.httpMethod = "GET"
        
        // when
        let request = APIRequest<String, TestError>.get("/path", parameters: ["appid": "value"])
        let result = URLRequest(baseURL: aURL, apiRequest: request)
        
        // then
        XCTAssertEqual(result, expected)
    }
    
    func test_givenAURLPath_andAParameter_whenCreateRequest_thenRequestHasConfiguredParameter() {
        // given
        let URLWithPath = aURL.appendingPathComponent("/path")
        
        var components = URLComponents(url: URLWithPath, resolvingAgainstBaseURL: false)!
        components.query = "lang=en"
        
        var expected = URLRequest(url: components.url!)
        expected.addValue("application/json", forHTTPHeaderField: "Accept")
        expected.httpMethod = "GET"
        
        // when
        let request = APIRequest<String, TestError>.get("/path")
        let result = URLRequest(baseURL: aURL, apiRequest: request).addingParameters(["lang": "en"])
        
        // then
        XCTAssertEqual(result, expected)
    }
    
    func test_givenAURLPath_andHeaders_whenCreateRequest_thenRequestHasConfiguredHeaders() {
        // given
        let URLWithPath = aURL.appendingPathComponent("/path")
        
        var expected = URLRequest(url: URLWithPath)
        expected.addValue("Bearer stub", forHTTPHeaderField: "Authorization")
        expected.addValue("application/json", forHTTPHeaderField: "Accept")
        expected.httpMethod = "GET"
        
        // when
        let request = APIRequest<String, TestError>.get("/path")
        let result = URLRequest(baseURL: aURL, apiRequest: request).addingHeaders([.authorization: "Bearer stub"])
        
        // then
        XCTAssertEqual(result, expected)
    }

}
