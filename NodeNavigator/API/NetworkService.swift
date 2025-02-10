//
//  NetworkService.swift
//  NodeNavigator
//
//  Created by Lucas Farah on 10/02/25.
//

import Foundation

public class NetworkService {
    /// Request a Decodable object from an APIEndpoint
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        guard let baseURL = APIKeys.baseURL else {
            throw NetworkError.invalidURL
        }
        let fullURL = baseURL.appending(path: endpoint.path)

        var request = URLRequest(url: fullURL)
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.invalidResponse
        }
    }
}
