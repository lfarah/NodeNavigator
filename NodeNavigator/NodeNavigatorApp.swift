//
//  NodeNavigatorApp.swift
//  NodeNavigator
//
//  Created by Lucas Farah on 10/02/25.
//

import SwiftUI
import SwiftData

@main
struct NodeNavigatorApp: App {

    private let nodeService = NodeService()

    var body: some Scene {
        WindowGroup {
            NodeListScreen(nodeService: nodeService)
        }
    }
}
