//
//  RemoteService.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import Foundation
import Combine

// MARK: - RemoteServiceError

/// An enumeration representing the possible errors that can occur when interacting with the remote service.
enum RemoteServiceError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case updateFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response."
        case .invalidData:
            return "Invalid data."
        case .updateFailed:
            return "Update failed."
        }
    }
}

// MARK: - RemoteServiceProtocol

/// A protocol defining the methods required for a remote service.
protocol RemoteServiceProtocol {
    func fetchAppliance(_ applianceId: String) -> AnyPublisher<Appliance, Error>
    func performAction(_ action: ApplianceAction, for appliance: Appliance) -> AnyPublisher<Appliance, Error>
}

// MARK: - RemoteService

/// A class that handles communication with a remote service to manage appliances.
class RemoteService: RemoteServiceProtocol {
    static let shared = RemoteService()
    private init() {}

    /// Fetches an appliance with a given ID.
    ///
    /// - Parameter applianceId: The ID of the appliance to fetch.
    /// - Returns: A publisher that emits the fetched appliance or an error.
    func fetchAppliance(_ applianceId: String) -> AnyPublisher<Appliance, Error> {
        guard let url = Bundle.main.url(forResource: "Oven", withExtension: "json") else {
            return Fail(error: RemoteServiceError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Appliance.self, decoder: JSONDecoder())
            .mapError { error in
                print("Error reading and decoding JSON file: \(error)")
                return RemoteServiceError.invalidData
            }
            .eraseToAnyPublisher()
    }

    /// Performs an action on an appliance and returns the updated appliance.
    ///
    /// - Parameters:
    ///   - action: The action to perform on the appliance.
    ///   - appliance: The appliance to perform the action on.
    /// - Returns: A publisher that emits the updated appliance or an error.
    func performAction(_ action: ApplianceAction, for appliance: Appliance) -> AnyPublisher<Appliance, Error> {
        switch action {
        case .updateProgram(let newProgram):
            return updateProgram(newProgram, for: appliance)
        case .updateTemperature(let newTemperature):
            return updateTemperature(newTemperature, for: appliance)
        case .toggleState:
            return toggleState(for: appliance)
        }
    }

    func updateProgram(_ newProgram: Program, for appliance: Appliance) -> AnyPublisher<Appliance, Error> {
        return Future<Appliance, Error> { promise in
            // Update the appliance's program
            var modifiedAppliance = appliance
            modifiedAppliance.properties.program = newProgram
            promise(.success(modifiedAppliance))
        }.eraseToAnyPublisher()
    }

    func updateTemperature(_ newTemperature: Int, for appliance: Appliance) -> AnyPublisher<Appliance, Error> {
        return Future<Appliance, Error> { promise in
            // Update the appliance's temperature
            var modifiedAppliance = appliance
            modifiedAppliance.properties.targetTemperature = newTemperature
            promise(.success(modifiedAppliance))
        }.eraseToAnyPublisher()
    }

    func toggleState(for appliance: Appliance) -> AnyPublisher<Appliance, Error> {
        return Future<Appliance, Error> { promise in
            // Toggle the appliance's state
            var modifiedAppliance = appliance
            modifiedAppliance.properties.applianceState = modifiedAppliance.properties.applianceState == .readyToStart ? .running : .readyToStart
            promise(.success(modifiedAppliance))
        }.eraseToAnyPublisher()
    }
}

// MARK: - ApplianceAction

/// An enumeration representing the possible actions that can be performed on an appliance.
enum ApplianceAction {
    case updateProgram(Program)
    case updateTemperature(Int)
    case toggleState
}
