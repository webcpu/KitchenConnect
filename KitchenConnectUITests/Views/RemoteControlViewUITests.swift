//
//  RemoteControlViewUITests.swift
//  KitchenConnectUITests
//
//  Created by liang on 02/04/2023.
//

import XCTest
@testable import KitchenConnect
import SwiftUI

class RemoteControlViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        app = nil
    }

    func testRemoteControlViewElements() {
        // Navigate to the RemoteControlView if necessary
        // Tap on the appliance cell
        let applianceButton = app.buttons.matching(identifier: "appliance-12CFD").element(boundBy: 0)
        applianceButton.tap()

        // Test if the appliance name is displayed
        let applianceName = app.staticTexts["remote-control-appliance-12CFD"]
        XCTAssertTrue(applianceName.exists)

        // Test if the "TURN ON" button is displayed
        let turnOnButton = app.buttons["TURN ON"]
        XCTAssertTrue(turnOnButton.exists)

        // Test if the "TURN OFF" button is displayed
        let turnOffButton = app.buttons["TURN OFF"]
        XCTAssertFalse(turnOffButton.exists)

        // Test if the navigation bar exists
        let navigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(navigationBar.exists)

        // Test if the back button exists and tap it
        let backButton = navigationBar.buttons.firstMatch
        let backButtonExists = backButton.waitForExistence(timeout: 5)
        XCTAssertTrue(backButtonExists)
    }

    func testTurnOnOffAppliance() {
        // Navigate to the RemoteControlView if necessary
        let applianceButton = app.buttons.matching(identifier: "appliance-12CFD").element(boundBy: 0)
        applianceButton.tap()

        // Test if the "TURN ON" button is displayed and tap it
        let turnOnButton = app.buttons["TURN ON"]
        XCTAssertTrue(turnOnButton.exists)
        turnOnButton.tap()

        // Test if the "TURN OFF" button is displayed and tap it
        let turnOffButton = app.buttons["TURN OFF"]
        XCTAssertTrue(turnOffButton.exists)
        turnOffButton.tap()
    }
}
