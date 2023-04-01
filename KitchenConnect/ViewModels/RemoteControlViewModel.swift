//
//  RemoteControlViewModel.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import Foundation
import SwiftUI
import Combine

class RemoteControlViewModel: ObservableObject {
    @Published var appliance: Appliance
    @Published var selectedProgram: Program
    @Published var targetTemperature: Int
    
    var cancellables: Set<AnyCancellable> = []

    private let remoteService = RemoteService.shared

    init(appliance: Appliance) {
        self.appliance = appliance
        self.selectedProgram = appliance.program
        self.targetTemperature = appliance.properties.targetTemperature
    }

    // Define methods to control the appliance, such as changing the program or adjusting the temperature
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
