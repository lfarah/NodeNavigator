//
//  NodeListViewModel.swift
//  NodeNavigator
//
//  Created by Lucas Farah on 10/02/25.
//

import Foundation
import Combine

enum NodeListState {
    case loading
    case data(nodes: [Node])
    case error
}

class NodeListViewModel: ObservableObject {
    private var nodes: [Node] = []
    @Published var state: NodeListState = .loading

    private let nodeService: NodeServiceProtocol

    init(nodeService: NodeServiceProtocol) {
        self.nodeService = nodeService
    }

    @MainActor
    func reload() async {
        state = .loading
        do {
            let nodes: [Node] = try await nodeService.fetchNodes()
            self.nodes = nodes
            state = .data(nodes: nodes)
        } catch {
            state = .error
            print("Error: \(error)")
        }
    }
}
