//
//  Node.swift
//  NodeNavigator
//
//  Created by Lucas Farah on 10/02/25.
//

import Foundation

public struct Node: Codable {
    let publicKey: String
    let alias: String
    let channels: Int
    let capacity: Int
    let firstSeen: Int
    let updatedAt: Date
    let city: [String: String]?
    let country: [String: String]?
}
