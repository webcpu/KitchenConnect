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
    let properties: Properties
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
}

struct ApplianceData: Codable {
    let applianceName: String
}

struct Properties: Codable {
    let doorState: String
    let temperatureRepresentation: String
    let targetTemperature: Int
    let program: Program
    let startTime: Int
    let targetDuration: Int
    let runningTime: Int
    let applianceState: ApplianceState
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
