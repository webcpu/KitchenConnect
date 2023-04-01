//
//  RemoteService.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import Foundation
import Combine

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

protocol RemoteServiceProtocol {
    func performAction(_ action: ApplianceAction, for appliance: Appliance) -> AnyPublisher<Appliance, Error>
}

class RemoteService: RemoteServiceProtocol {
    static let shared = RemoteService()
    
    private init() {}
    
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
    
    func performAction(_ action: ApplianceAction, for appliance: Appliance) -> AnyPublisher<Appliance, Error> {
        // Implement your logic here to perform the action
        // You can use a switch statement to determine the appropriate action
        
        var appliance = appliance
        switch action {
        case .updateProgram(let newProgram):
            // Perform the update program action
            return Future<Appliance, Error> { promise in
                // Update the appliance's program
                // Replace this with the actual API call or async task
                appliance.properties.program = newProgram
                promise(.success(appliance))
            }.eraseToAnyPublisher()
            
        case .updateTemperature(let newTemperature):
            // Perform the update temperature action
            return Future<Appliance, Error> { promise in
                // Update the appliance's temperature
                // Replace this with the actual API call or async task
                appliance.properties.targetTemperature = newTemperature
                promise(.success(appliance))
            }.eraseToAnyPublisher()
            
        case .toggleState:
            // Perform the toggle appliance state action
            print("toggleState")
            return Future<Appliance, Error> { promise in
                // Toggle the appliance's state
                // Replace this with the actual API call or async task
                appliance.properties.applianceState = appliance.properties.applianceState == .readyToStart ? .running : .readyToStart
                promise(.success(appliance))
            }.eraseToAnyPublisher()
        }
    }
}

enum ApplianceAction {
    case updateProgram(Program)
    case updateTemperature(Int)
    case toggleState
}
