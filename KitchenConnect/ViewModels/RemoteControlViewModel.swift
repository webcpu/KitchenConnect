//
//  RemoteControlViewModel.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import Foundation
import SwiftUI
import Combine

// MARK: - RemoteControlViewModel

/// A view model for the `RemoteControlView`.
///
/// This class handles controlling the appliance, such as changing the program, adjusting the temperature, and
/// toggling the appliance state. It also manages the state of the view and updates the appliance properties
/// when a response is received from the remote service.
/// 
class RemoteControlViewModel: ObservableObject {
    
    // MARK: - Properties

    /// The appliance being controlled.
    @Published var appliance: Appliance
    
    /// The selected program for the appliance.
    @Published var selectedProgram: Program
    
    /// The target temperature for the appliance.
    @Published var targetTemperature: Int
    
    /// A set of `AnyCancellable` objects for managing Combine subscriptions.
    var cancellables: Set<AnyCancellable> = []

    /// The remote service used for controlling the appliance.
    private let remoteService: RemoteServiceProtocol

    // MARK: - Initialization

    /// Initializes a new instance of the view model with the specified appliance and remote service.
    ///
    /// - Parameters:
    ///   - appliance: The appliance to control.
    ///   - remoteService: The remote service used for controlling the appliance.
    init(appliance: Appliance, remoteService: RemoteServiceProtocol) {
        self.appliance = appliance
        self.selectedProgram = appliance.program
        self.targetTemperature = appliance.properties.targetTemperature
        self.remoteService = remoteService
    }

    // MARK: - Methods

    /// Changes the program of the appliance to the specified new program.
    ///
    /// - Parameter newProgram: The new program for the appliance.
    func changeProgram(to newProgram: Program) {
        remoteService.performAction(.updateProgram(newProgram), for: appliance)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    print("Completed")
                }
            }, receiveValue: { updatedAppliance in
                self.appliance = updatedAppliance
                self.selectedProgram = self.appliance.properties.program})
            .store(in: &cancellables)
    }
    
    /// Updates the target temperature of the appliance to the specified new temperature.
    ///
    /// - Parameter newTemperature: The new target temperature for the appliance.
    func updateTargetTemperature(to newTemperature: Int) {
        remoteService.performAction(.updateTemperature(newTemperature), for: appliance)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    print("Completed")
                }
            }, receiveValue: { updatedAppliance in
                self.appliance = updatedAppliance
                self.targetTemperature = self.appliance.properties.targetTemperature
            })
            .store(in: &cancellables)
    }
    
    /// Toggles the state of the appliance between on and off.
    func toggleApplianceState() {
        remoteService.performAction(.toggleState, for: appliance)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    print("Completed")
                }
            }, receiveValue: { updatedAppliance in
                self.appliance = updatedAppliance
            })
            .store(in: &cancellables)
    }
}
