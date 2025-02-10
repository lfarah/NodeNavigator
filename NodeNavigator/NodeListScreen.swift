//
//  ContentView.swift
//  NodeNavigator
//
//  Created by Lucas Farah on 10/02/25.
//

import SwiftUI

struct NodeListScreen: View {
    @ObservedObject var viewModel: NodeListViewModel

    init(nodeService: NodeServiceProtocol) {
        _viewModel = ObservedObject(wrappedValue: NodeListViewModel(nodeService: nodeService))
    }

    var body: some View {
        NavigationView {
            List {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case let .data(nodes):
                    ForEach(nodes, id: \.publicKey) { node in
                        NodeListRow(model: node)
                    }
                case .error:
                    Text("Error")
                }
            }
            .refreshable {
                Task {
                    await viewModel.reload()
                }
            }
            .navigationTitle("Nodes")
        }
        .task {
            await viewModel.reload()
        }
    }
}

#Preview {
    NodeListScreen(nodeService: NodeService())
}
