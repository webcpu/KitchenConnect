//
//  RemoteControlViewModelTests.swift
//  KitchenConnectTests
//
//  Created by liang on 01/04/2023.
//

import XCTest
import Combine

@testable import KitchenConnect

final class RemoteControlViewModelTests: XCTestCase {
    var viewModel: RemoteControlViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        if let appliance = createSampleAppliance() {
            viewModel = RemoteControlViewModel(appliance: appliance)
        }
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testChangeProgram() {
        XCTAssertNotNil(viewModel)
        let expectation = XCTestExpectation(description: "Change program")

        viewModel.changeProgram(to: .bake)
        viewModel.$selectedProgram
            .sink { selectedProgram in
                print(selectedProgram)
                if selectedProgram == .bake {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }

    func testUpdateTargetTemperature() {
        XCTAssertNotNil(viewModel)
        let expectation = XCTestExpectation(description: "Update target temperature")

        viewModel.updateTargetTemperature(to: 200)

        viewModel.$targetTemperature
            .sink { targetTemperature in
                if targetTemperature == 200 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testToggleApplianceState() {
        XCTAssertNotNil(viewModel)
        let expectation = XCTestExpectation(description: "Toggle appliance state")

        let oldState = viewModel.appliance.properties.applianceState
        viewModel.toggleApplianceState()
        viewModel.$appliance
            .sink { newAppliance in
                if newAppliance.properties.applianceState != oldState {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Add checks for the RemoteService to verify the appliance state change was propagated correctly
        // You will need to update the RemoteService to provide a publisher for appliance state changes

        wait(for: [expectation], timeout: 1.0)
    }

    
    // Helper method to create a sample Appliance
    private func createSampleAppliance() -> Appliance? {
        let data = loadJSONDataFromFile()
        let decoder = JSONDecoder()
        return (try? decoder.decode(Appliance.self, from: data))
    }
    
    func loadJSONDataFromFile() -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Oven", withExtension: "json") else {
            fatalError("Failed to locate Oven.json in bundle.")
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            fatalError("Failed to load Oven.json from bundle: \(error)")
        }
    }
}
