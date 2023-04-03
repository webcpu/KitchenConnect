//
//  Appliance.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import Foundation

// MARK: - Appliance

/// A struct representing a home appliance.
struct Appliance: Codable {

    /// The unique identifier of the appliance.
    var applianceId: String

    /// The data for the appliance.
    var applianceData: ApplianceData

    /// The current properties of the appliance.
    var properties: Properties
}

// MARK: - ApplianceData

/// A struct representing the data for an appliance.
struct ApplianceData: Codable {

    // MARK: - Properties

    /// The name of the appliance.
    let applianceName: String
}

// MARK: - Properties

/// A struct representing the current properties of an appliance.
struct Properties: Codable {

    /// The current door state of the appliance.
    let doorState: DoorState

    /// The temperature representation used by the appliance ("CELSIUS" or "FAHRENHEIT").
    let temperatureRepresentation: TemperatureRepresentation

    /// The current target temperature of the appliance.
    var targetTemperature: Int

    /// The current program of the appliance.
    var program: Program

    /// The start time of the appliance's current cycle.
    let startTime: Int

    /// The target duration of the appliance's current cycle.
    let targetDuration: Int

    /// The running time of the appliance's current cycle.
    let runningTime: Int

    /// The current state of the appliance.
    var applianceState: ApplianceState

    /// The current display temperature of the appliance.
    let displayTemperature: Int
}

// MARK: - DoorState

// DoorState enum
enum DoorState: String, Codable {
    case open = "OPEN"
    case closed = "CLOSED"
}

// MARK: - TemperatureRepresentation

// TemperatureRepresentation enum
enum TemperatureRepresentation: String, Codable {
    case celsius = "CELSIUS"
    case fahrenheit = "FAHRENHEIT"
}

// MARK: - ApplianceState

/// An enumeration representing the possible states of an appliance.
enum ApplianceState: String, Codable {
    case readyToStart = "READY_TO_START"
    case running = "RUNNING"
    case paused = "PAUSED"
    case finished = "FINISHED"
    case error = "ERROR"
}

// MARK: - Program

/// An enumeration representing the possible programs for an appliance.
enum Program: String, Codable {
    case grill = "GRILL"
    case bake = "BAKE"
    case broil = "BROIL"
    case convection = "CONVECTION"
    case defrost = "DEFROST"
    case preheat = "PREHEAT"
    case keepWarm = "KEEP_WARM"
}

// MARK: - Appliance Computed Properties and Methods

extension Appliance {
    /// The name of the appliance.
    var name: String {
        return applianceData.applianceName
    }

    /// The current state of the appliance as a string ("Off" or "On").
    var state: String {
        return properties.applianceState == .readyToStart ? "Off" : "On"
    }

    /// The current program of the appliance.
    var program: Program {
        return properties.program
    }

    /// The current temperature of the appliance as a string with the appropriate temperature unit.
    var displayTemperatureWithUnit: String {
        let celsiusSymbol = "\u{2103}" // Celsius degree symbol
        let fahrenheitSymbol = "\u{2109}" // Fahrenheit degree symbol
        let symbol = properties.temperatureRepresentation != .celsius ? fahrenheitSymbol : celsiusSymbol
        return "\(properties.displayTemperature)\(symbol)"
    }

    /// The possible actions that can be performed on an appliance.
    enum ApplianceAction {
        case turnOn
        case turnOff
        case changeProgram(Program)
        case changeTemperature(Int)
    }

    /// Performs the specified action on the appliance.
    ///
    /// - Parameter action: The action to perform on the appliance.
    mutating func performAction(_ action: ApplianceAction) {
        switch action {
        case .turnOn:
            properties.applianceState = .running
        case .turnOff:
            properties.applianceState = .readyToStart
        case .changeProgram(let newProgram):
            properties.program = newProgram
        case .changeTemperature(let newTemperature):
            properties.targetTemperature = newTemperature
        }
    }

    // MARK: - Helper Methods

    /// Returns an updated `Appliance` with the specified program.
    ///
    /// - Parameter newProgram: The new program for the appliance.
    func withUpdatedProgram(_ newProgram: Program) -> Appliance {
        var updatedAppliance = self
        updatedAppliance.properties.program = newProgram
        return updatedAppliance
    }

    /// Returns an updated `Appliance` with the specified temperature.
    ///
    /// - Parameter newTemperature: The new target temperature for the appliance.
    func withUpdatedTemperature(_ newTemperature: Int) -> Appliance {
        var updatedAppliance = self
        updatedAppliance.properties.targetTemperature = newTemperature
        return updatedAppliance
    }

    /// Returns an updated `Appliance` with the specified state.
    ///
    /// - Parameter newState: The new state for the appliance.
    func withUpdatedState(_ newState: ApplianceState) -> Appliance {
        var updatedAppliance = self
        updatedAppliance.properties.applianceState = newState
        return updatedAppliance
    }
}
