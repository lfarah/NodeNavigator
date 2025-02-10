//
//  NodeService.swift
//  NodeNavigator
//
//  Created by Lucas Farah on 10/02/25.
//

import Foundation

public protocol NodeServiceProtocol {
    func fetchNodes() async throws -> [Node]
}

public class NodeService: NetworkService, NodeServiceProtocol {
    public func fetchNodes() async throws -> [Node] {
        try await request(NodeEndpoint.lightningNodes)
    }
}
