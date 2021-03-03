//
//  APIClientTest.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import XCTest
import Combine
@testable import WeatherApp

final class APIClientTest: XCTestCase {
    private var sut: APIClient!
    
    private let url = URL(string: "https://example.com")!
    private let configuration = APIClientConfiguration()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        sut = APIClient(baseURL: url, configuration: configuration, session: .stubbed)
    }
    
    override func tearDown() {
        HTTPStubProtocol.removeAllStubs()
        
        super.tearDown()
    }
    
    func test_givenAnyValidResponse_whenResponse_thenReturnsOutput() throws {
        // given
        let request = APIRequest<String, TestError>.get("/user", jsonDecoder: JSONDecoder.openWeatherDecoder)
        try HTTPStubProtocol.stub(output: "stub", statusCode: 200, for: request, baseURL: url)
        let didReceiveValue = expectation(description: "didReceiveValue")
        var result: String?

        // when
        sut.response(for: request)
            .assertNoFailure()
            .sink(receiveValue: {
                result = $0
                didReceiveValue.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [didReceiveValue], timeout: 1)

        // then
        XCTAssertEqual(result, "stub")
    }
    
}
