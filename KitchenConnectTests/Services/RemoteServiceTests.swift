//
//  RemoteServiceTests.swift
//  KitchenConnectTests
//
//  Created by liang on 01/04/2023.
//

import XCTest
import Combine
@testable import KitchenConnect

final class RemoteServiceTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []

    func testFetchApplianceSuccess() {
        let remoteService = RemoteService.shared
        let expectation = XCTestExpectation(description: "Fetch appliance data successfully")

        remoteService.fetchAppliance("12CFD")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Error fetching appliance data: \(error.localizedDescription)")
                }
                expectation.fulfill()
            } receiveValue: { appliance in
                XCTAssertEqual(appliance.applianceId, "12CFD")
                XCTAssertEqual(appliance.name, "My oven")
                XCTAssertEqual(appliance.state, "Off")
                XCTAssertEqual(appliance.program.rawValue, "GRILL")
                XCTAssertEqual(appliance.displayTemperature, 24)
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10)
    }
}
