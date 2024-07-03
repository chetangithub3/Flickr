//
//  NetworkError.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case decodingError
    case unknown
}
