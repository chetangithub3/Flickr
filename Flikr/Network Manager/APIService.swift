//
//  APIService.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import Foundation

struct APIService: APIServiceProtocol {
    func fetch(request: URLRequest?) async -> Result<Data, NetworkError> {
        guard let request = request else {
            return .failure(NetworkError.badRequest)
        }
        do {
            let (data,_) = try await URLSession.shared.data(for: request)
            return .success(data)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
}
