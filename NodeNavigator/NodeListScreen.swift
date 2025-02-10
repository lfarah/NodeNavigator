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
                    HStack {
                        Spacer()
                        ProgressView()
                            .tint(.accent)
                            .frame(width: 100, height: 100)

                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                case let .data(nodes):
                    ForEach(nodes, id: \.publicKey) { node in
                        NodeListRow(model: node)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                case .error:
                    Text("Error fetching nodes. Please Pull to Refresh")
                        .font(.headline)
                        .listRowSeparator(.hidden)
                }
            }
            .refreshable {
                Task {
                    await viewModel.reload()
                }
            }
            .searchable(text: $viewModel.searchText)
            .listStyle(.plain)
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
