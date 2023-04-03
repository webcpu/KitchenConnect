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

    // A property to store the error that occurred. When an error occurs, it is assigned to this property
    // so that it can be displayed to the user.
    @Published var error: Error?

    // A Boolean property that determines whether the error alert is currently presented or not.
    // This property is used to control the presentation of the error alert view in SwiftUI.
    @Published var isErrorAlertPresented = false

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
                    self.showError(error: error)
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

    /// Shows an error alert view to the user.
    ///
    /// This method updates the `error` property with the given error parameter, and sets the
    /// `isErrorAlertPresented` property to `true`. This triggers the presentation of an error alert view
    /// in the SwiftUI view hierarchy, displaying the error message to the user.
    ///
    /// - Parameter error: The error to display to the user.
    func showError(error: Error) {
        self.error = error
        self.isErrorAlertPresented = true
    }
}
