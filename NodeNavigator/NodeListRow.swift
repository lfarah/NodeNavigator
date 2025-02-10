//
//  NodeListRow.swift
//  NodeNavigator
//
//  Created by Lucas Farah on 10/02/25.
//

import SwiftUI

struct NodeListRowModel {
    let publicKey: String
    let alias: String
    let channels: String
    let capacity: String
    let firstSeen: Date
    let updatedAt: Date
    let city: String?
    let country: String?
}

struct NodeListRow: View {
    let model: NodeListRowModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(model.alias)
                .font(.headline)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                if let city = model.city {
                    Text("\(city),")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                if let country = model.country {
                    Text(country)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Text(model.publicKey)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Text("Capacity:")
                    .font(.subheadline.bold())
                    .foregroundStyle(.secondary)

                Text(model.capacity)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack {
                Text("First Seen:")
                    .font(.subheadline.bold())
                    .foregroundStyle(.secondary)

                Text(model.firstSeen, style: .date)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 2) {
                Text(model.channels)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("Channels")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 2) {
                Text("Updated")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(model.updatedAt, style: .relative)
                    .font(.subheadline.monospacedDigit())
                    .foregroundStyle(.secondary)

                Text("ago")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    NodeListRow(
        model: NodeListRowModel(
            publicKey: "publicKey",
            alias: "My Node",
            channels: "3",
            capacity: "0,00550000 BTC",
            firstSeen: Date(timeIntervalSince1970: 0),
            updatedAt: Date(),
            city: "São Paulo",
            country: "Brazil"
        )
    )
    .padding()
}
