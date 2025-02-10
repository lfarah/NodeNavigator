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
    let capacity: Double
    let firstSeen: Date
    let updatedAt: Date
    let city: [String: String]?
    let country: [String: String]?

    public init(
        publicKey: String,
        alias: String,
        channels: Int,
        capacity: Double,
        firstSeen: Date,
        updatedAt: Date,
        city: [String : String]?,
        country: [String : String]?
    ) {
        self.publicKey = publicKey
        self.alias = alias
        self.channels = channels
        self.capacity = capacity
        self.firstSeen = firstSeen
        self.updatedAt = updatedAt
        self.city = city
        self.country = country
    }
}
