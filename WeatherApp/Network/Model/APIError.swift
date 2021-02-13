//
//  APIError.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation

enum APIClientError<Error>: Swift.Error {
    case loadingError(Swift.Error)
    case decodingError(DecodingError)
    case apiError(APIError<Error>)

    init(_ error: Swift.Error) {
        switch error {
        case let apiError as APIError<Error>:
            self = .apiError(apiError)
        case let decodingError as DecodingError:
            self = .decodingError(decodingError)
        default:
            self = .loadingError(error)
        }
    }
}

extension APIClientError {
    var loadingError: Swift.Error? {
        guard case let .loadingError(value) = self else { return nil }
        return value
    }

    var decodingError: DecodingError? {
        guard case let .decodingError(value) = self else { return nil }
        return value
    }

    var apiError: APIError<Error>? {
        guard case let .apiError(value) = self else { return nil }
        return value
    }
}

struct APIError<Error>: Swift.Error {
    let statusCode: Int
    let error: Error?
    
    init(statusCode: Int, error: Error?) {
        self.statusCode = statusCode
        self.error = error
    }
}

extension APIError: Equatable where Error: Equatable {}
