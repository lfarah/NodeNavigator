//
//  NodeListViewModelTests.swift
//  NodeNavigatorTests
//
//  Created by Lucas Farah on 10/02/25.
//

import Foundation
import Testing
@testable import NodeNavigator

struct NodeListViewModelTests {

    @Test func testLoadSuccessfullyCapacity() async throws {
        // given
        let service = NodeServiceMock()
        service.result = .success([Node.mock(capacity: 550_000)])
        let viewModel = NodeListViewModel(nodeService: service)

        #expect(viewModel.state.isLoading)

        // when
        await viewModel.reload()

        // then
        switch viewModel.state {
        case let .data(nodes):
            #expect(nodes.first?.capacity == "0,00550000 BTC")
        default:
            #expect(Bool(false))
        }
    }

    @Test func testLoadSuccessfullyCityEn() async throws {
        // given
        let service = NodeServiceMock()
        service.result = .success([Node.mock(city: ["en": "New York"])])
        let viewModel = NodeListViewModel(nodeService: service)
        
        #expect(viewModel.state.isLoading)

        // when
        await viewModel.reload()

        // then
        switch viewModel.state {
        case let .data(nodes):
            #expect(nodes.first?.city == "New York")
            #expect(nodes.first?.country == nil)

        default:
            #expect(Bool(false))
        }
    }

    @Test func testLoadSuccessfullyCityCountryEn() async throws {
        // given
        let service = NodeServiceMock()
        service.result = .success(
            [Node.mock(
                city: ["en": "New York"],
                country: ["en": "United States"]
            )]
        )
        let viewModel = NodeListViewModel(nodeService: service)

        #expect(viewModel.state.isLoading)

        // when
        await viewModel.reload()

        // then
        switch viewModel.state {
        case let .data(nodes):
            #expect(nodes.first?.city == "New York")
            #expect(nodes.first?.country == "United States")
        default:
            #expect(Bool(false))
        }
    }

    @Test func testLoadSuccessfullyCityPt() async throws {
        // given
        let service = NodeServiceMock()
        service.result = .success(
            [Node.mock(
                city: [
                    "en": "New York",
                    "pt-BR": "Nova Iorque"
                ],
                country: nil
            )]
        )
        let viewModel = NodeListViewModel(nodeService: service)

        #expect(viewModel.state.isLoading)

        // when
        await viewModel.reload()

        // then
        switch viewModel.state {
        case let .data(nodes):
            #expect(nodes.first?.city == "Nova Iorque")
            #expect(nodes.first?.country == nil)

        default:
            #expect(Bool(false))
        }
    }

    @Test func testLoadSuccessfullyCityCountryPt() async throws {
        // given
        let service = NodeServiceMock()
        service.result = .success(
            [Node.mock(
                city: [
                    "en": "New York",
                    "pt-BR": "Nova Iorque"
                ],
                country: [
                    "en": "United States",
                    "pt-BR": "EUA"
                ]
            )]
        )
        let viewModel = NodeListViewModel(nodeService: service)

        #expect(viewModel.state.isLoading)

        // when
        await viewModel.reload()

        // then
        switch viewModel.state {
        case let .data(nodes):
            #expect(nodes.first?.city == "Nova Iorque")
            #expect(nodes.first?.country == "EUA")
        default:
            #expect(Bool(false))
        }
    }

    @Test func testLoadFailure() async throws {
        // given
        let service = NodeServiceMock()
        service.result = .failure(NetworkError.invalidResponse)
        let viewModel = NodeListViewModel(nodeService: service)

        #expect(viewModel.state.isLoading)

        // when
        await viewModel.reload()

        // then
        switch viewModel.state {
        case .error:
            #expect(Bool(true))
        default:
            #expect(Bool(false))
        }
    }

    @Test func testSearch() async throws {
        // given
        let service = NodeServiceMock()
        service.result = .success([
            Node.mock(
                alias: "My Node",
                city: [
                    "en": "New York",
                    "pt-BR": "Nova Iorque"
                ],
                country: [
                    "en": "United States",
                    "pt-BR": "EUA"
                ]
            ),
            Node.mock(
                alias: "Another Node",
                city: [
                    "en": "New York",
                    "pt-BR": "Nova Iorque"
                ],
                country: [
                    "en": "United States",
                    "pt-BR": "EUA"
                ]
            )
        ])
        let viewModel = NodeListViewModel(nodeService: service)
        await viewModel.reload()

        // when
        viewModel.search(text: "My No")
        
        // then
        switch viewModel.state {
        case let .data(nodes):
            #expect(nodes.count == 1)
            #expect(nodes.first?.alias == "My Node")
        default:
            #expect(Bool(false))
        }
    }

    @Test func testSearchEmpty() async throws {
        // given
        let service = NodeServiceMock()
        service.result = .success([
            Node.mock(
                alias: "My Node",
                city: [
                    "en": "New York",
                    "pt-BR": "Nova Iorque"
                ],
                country: [
                    "en": "United States",
                    "pt-BR": "EUA"
                ]
            ),
            Node.mock(
                alias: "Another Node",
                city: [
                    "en": "New York",
                    "pt-BR": "Nova Iorque"
                ],
                country: [
                    "en": "United States",
                    "pt-BR": "EUA"
                ]
            )
        ])
        let viewModel = NodeListViewModel(nodeService: service)
        await viewModel.reload()

        // when
        viewModel.search(text: "")

        // then
        switch viewModel.state {
        case let .data(nodes):
            #expect(nodes.count == 2)
        default:
            #expect(Bool(false))
        }
    }
}
