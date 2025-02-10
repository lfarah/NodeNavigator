//
//  NodeEndpoint.swift
//  NodeNavigator
//
//  Created by Lucas Farah on 10/02/25.
//

import Foundation

enum NodeEndpoint: APIEndpoint {
    case lightningNodes

    var path: String {
        switch self {
        case .lightningNodes:
            return "/lightning/nodes/rankings/connectivity"
        }
    }

    var method: String {
        switch self {
        case .lightningNodes:
            "GET"
        }
    }

    var body: Data? {
        nil
    }
}
