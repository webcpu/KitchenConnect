//
//  KitchenConnectUITests.swift
//  KitchenConnectUITests
//
//  Created by liang on 01/04/2023.
//

import XCTest

final class KitchenConnectUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    func testApplianceList() throws {
        // Check if the home view is displayed
        let homeView = app.navigationBars["Home"]
        XCTAssertTrue(homeView.exists, "Home view is not displayed")
        

        // Check if an appliance cell is displayed
        let applianceButton = app.buttons.matching(identifier: "appliance-12CFD").element(boundBy: 0)

        // Wait for the appliance cell to exist with a timeout
        let buttonExists = applianceButton.waitForExistence(timeout: 5)
        
        // Check if an appliance cell is displayed

        XCTAssertTrue(buttonExists, "Appliance cell is not displayed")

        // Check if appliance name is displayed
        let applianceName = applianceButton.staticTexts["applianceName"]
        XCTAssertTrue(applianceName.exists, "Appliance name is not displayed")
    }
    
    func testApplianceNavigation() throws {
        // Tap on the appliance cell
        let applianceButton = app.buttons.matching(identifier: "appliance-12CFD").element(boundBy: 0)
        applianceButton.tap()
        
        // Check if the RemoteControlView is displayed
        let remoteControlView = app.staticTexts.matching(identifier: "remote-control-appliance-12CFD").element(boundBy: 0) 
        XCTAssertTrue(remoteControlView.exists, "Remote Control view is not displayed")
    }
}
