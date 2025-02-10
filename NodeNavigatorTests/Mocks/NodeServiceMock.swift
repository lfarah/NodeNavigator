//
//  NodeServiceMock.swift
//  NodeNavigatorTests
//
//  Created by Lucas Farah on 10/02/25.
//

import Foundation
import NodeNavigator

class NodeServiceMock: NodeServiceProtocol {
    var result: Result<[Node], Error>?
    func fetchNodes() async throws -> [Node] {
        switch result {
        case .success(let nodes):
            nodes
        case .failure(let failure):
            throw failure
        case nil:
            throw NetworkError.invalidResponse
        }
    }
}
