//
//  HomeViewModelTests.swift
//  KitchenConnectTests
//
//  Created by liang on 01/04/2023.
//

import XCTest
import Combine
@testable import KitchenConnect

final class HomeViewModelTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []

    func testFetchAppliances() {
        let viewModel = HomeViewModel(remoteService: RemoteService.shared)
        let expectation = XCTestExpectation(description: "Fetch appliances successfully")

        viewModel.$appliances
            .dropFirst() // Ignore the initial value
            .sink { appliances in
                XCTAssertFalse(appliances.isEmpty)
                XCTAssertTrue(appliances.contains { $0.key == "12CFD" })
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchAppliances()

        wait(for: [expectation], timeout: 10)
    }
}
