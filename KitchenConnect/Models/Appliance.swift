//
//  Appliance.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import Foundation

struct Appliance: Codable {
    let applianceId: String
    let applianceData: ApplianceData
    var properties: Properties
}

extension Appliance {
    var name: String {
        return applianceData.applianceName
    }
    
    var state: String {
        return properties.applianceState == .readyToStart ? "Off" : "On"
    }
    
    var program: Program {
        return properties.program
    }
    
    var displayTemperature: Int {
        return properties.displayTemperature
    }
    
    enum ApplianceAction {
            case turnOn
            case turnOff
            case changeProgram(Program)
            case changeTemperature(Int)
        }
        
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
    
    func withUpdatedProgram(_ newProgram: Program) -> Appliance {
        var updatedAppliance = self
        updatedAppliance.properties.program = newProgram
        return updatedAppliance
    }
    
    func withUpdatedTemperature(_ newTemperature: Int) -> Appliance {
        var updatedAppliance = self
        updatedAppliance.properties.targetTemperature = newTemperature
        return updatedAppliance
    }
    
    func withUpdatedState(_ newState: ApplianceState) -> Appliance {
        var updatedAppliance = self
        updatedAppliance.properties.applianceState = newState
        return updatedAppliance
    }
}

struct ApplianceData: Codable {
    let applianceName: String
}

struct Properties: Codable {
    let doorState: String
    let temperatureRepresentation: String
    var targetTemperature: Int
    var program: Program
    let startTime: Int
    let targetDuration: Int
    let runningTime: Int
    var applianceState: ApplianceState
    let displayTemperature: Int
}

enum ApplianceState: String, Codable {
    case readyToStart = "READY_TO_START"
    case running = "RUNNING"
    case paused = "PAUSED"
    case finished = "FINISHED"
    case error = "ERROR"
}

enum Program: String, Codable {
    case grill = "GRILL"
    case bake = "BAKE"
    case broil = "BROIL"
    case convection = "CONVECTION"
    case defrost = "DEFROST"
    case preheat = "PREHEAT"
    case keepWarm = "KEEP_WARM"
}
