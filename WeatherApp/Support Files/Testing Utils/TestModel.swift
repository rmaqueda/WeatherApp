//
//  TestModel.swift
//  WeatherAppTests
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import Foundation

struct User: Equatable, Codable {
    let name: String
}

struct TestError: Equatable, Codable {
    let message: String
}
