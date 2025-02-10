//
//  Node+Mock.swift
//  NodeNavigatorTests
//
//  Created by Lucas Farah on 10/02/25.
//

import Foundation
import NodeNavigator

extension Node {
    static func mock(
        publicKey: String = "publicKey",
        alias: String = "My Node",
        channels: Int = 3,
        capacity: Double = 1,
        firstSeen: Date = Date(
            timeIntervalSince1970: 0
        ),
        updatedAt: Date = Date(),
        city: [String : String]? = nil,
        country: [String : String]? = nil
    ) -> Node {
        Node(
            publicKey: publicKey,
            alias: alias,
            channels: channels,
            capacity: capacity,
            firstSeen: firstSeen,
            updatedAt: updatedAt,
            city: city,
            country: country
        )
    }
}
