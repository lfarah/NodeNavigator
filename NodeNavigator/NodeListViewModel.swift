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
    case data(nodes: [NodeListRowModel])
    case error

    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
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
            state = .data(nodes: nodes.map { nodeToRowModel(node: $0) })
        } catch {
            state = .error
            print("Error: \(error)")
        }
    }

    private func nodeToRowModel(node: Node) -> NodeListRowModel {
        NodeListRowModel(
            publicKey: node.publicKey,
            alias: node.alias,
            channels: "\(node.channels)",
            capacity: parseCapacity(for: node),
            firstSeen: node.firstSeen,
            updatedAt: node.updatedAt,
            city: node.city?["pt-BR"] ?? node.city?["en"],
            country: node.country?["pt-BR"] ?? node.country?["en"]
        )
    }

    private func parseCapacity(for node: Node) -> String {
        // 1 Bitcoin = 100.000.000
        let capacity = node.capacity / 100_000_000
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 8
        formatter.maximumFractionDigits = 8
        formatter.locale = Locale(identifier: "pt-BR")
        let formattedString = formatter.string(from: NSNumber(value: capacity)) ?? ""
        return "\(formattedString) BTC"
    }
}
