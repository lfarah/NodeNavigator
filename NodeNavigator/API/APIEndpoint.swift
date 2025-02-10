//
//  APIEndpoint.swift
//  NodeNavigator
//
//  Created by Lucas Farah on 10/02/25.
//

import Foundation

protocol APIEndpoint {
    var path: String { get }
    var method: String { get }
    var body: Data? { get }
}
