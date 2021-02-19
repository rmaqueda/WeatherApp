//
//  URLSession.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import Foundation

#if DEBUG
extension URLSession {
    
    static var stubbed: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [HTTPStubProtocol.self]
        URLProtocol.registerClass(HTTPStubProtocol.self)
        
        return URLSession(configuration: configuration)
    }
    
}
#endif
