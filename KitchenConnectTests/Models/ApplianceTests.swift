//
//  ApplianceTests.swift
//  KitchenConnectTests
//
//  Created by liang on 01/04/2023.
//

import XCTest
@testable import KitchenConnect

final class ApplianceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Helper method to load the JSON data from "Oven.json"
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
    
    // Test case for decoding the JSON object from "Oven.json" into the Appliance struct
    func testDecodeApplianceFromJSONFile() {
        let data = loadJSONDataFromFile()
        let decoder = JSONDecoder()
        
        do {
            let appliance = try decoder.decode(Appliance.self, from: data)
            
            XCTAssertEqual(appliance.applianceId, "12CFD")
            XCTAssertEqual(appliance.name, "My oven")
            XCTAssertEqual(appliance.state, "Off")
            XCTAssertEqual(appliance.program.rawValue, "GRILL")
            XCTAssertEqual(appliance.displayTemperatureWithUnit, "24"+"\u{2103}")
        } catch {
            XCTFail("Failed to decode Appliance from JSON: \(error)")
        }
    }
}
