//
//  NodeListViewModel.swift
//  NodeNavigator
//
//  Created by Lucas Farah on 10/02/25.
//

import Foundation

class NodeListViewModel: ObservableObject {
    @Published var nodes: [Node] = []
    private let nodeService: NodeServiceProtocol

    init(nodeService: NodeServiceProtocol) {
        self.nodeService = nodeService
    }

    @MainActor
    func reload() async {
        do {
            let nodes: [Node] = try await nodeService.fetchNodes()
            self.nodes = nodes
        } catch {
            print("Error: \(error)")
        }
    }
}
