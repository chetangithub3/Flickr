//
//  FlikrTests.swift
//  FlikrTests
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import Foundation
import SwiftUI

class MockAPIService: APIServiceProtocol {
  
    
    var shouldReturnError = false
    var responseData: Data?

    func fetch(request: URLRequest?) async -> Result<Data, NetworkError> {
        guard (request != nil) else {
            return .failure(NetworkError.badRequest)
        }
        if shouldReturnError {
            return .failure(NetworkError.unknown)
        } else if let data = responseData {
            return .success(data)
        } else {
            return .failure(NetworkError.unknown)
        }
    }
}
