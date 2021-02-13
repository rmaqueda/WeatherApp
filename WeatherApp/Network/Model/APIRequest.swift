//
//  APIRequest.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

struct APIRequest<Output, Error> {
    let method: Method
    let path: String
    let headers: [HeaderField: CustomStringConvertible]
    let parameters: [String: CustomStringConvertible]
    let body: Data?
    let output: (Data) throws -> Output
    let error: (Data) throws -> Error
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
}
