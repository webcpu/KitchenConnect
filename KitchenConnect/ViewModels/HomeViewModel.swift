//
//  HomeViewModel.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import Foundation
import OrderedCollections
import Combine

// MARK: - HomeViewModel

/// # KitchenConnect
///
/// ## View Models
///
/// A view model for the `HomeView`.
///
/// This class handles fetching appliance data and managing the state of the view. It contains a dictionary
/// of appliances, which is updated when appliances are fetched from the remote service.
///

class HomeViewModel: ObservableObject {
    
    // MARK: - Properties

    /// An ordered dictionary of appliances, with the appliance ID as the key.
    @Published var appliances: OrderedDictionary<String, Appliance> = [:]

    /// A list of appliance IDs used for fetching appliances from the remote service.
    private let ids: [String]
    private let remoteService: RemoteServiceProtocol
    
    /// A set of `AnyCancellable` objects for managing Combine subscriptions.
    var bag: Set<AnyCancellable> = []
    
    // MARK: - Methods
    
    /// Initializes the view model with the given appliance IDs.
    ///
    /// - Parameter ids: A list of appliance IDs used for fetching appliances from the remote service.
    init(ids: [String] = ["12CFD"], remoteService: RemoteServiceProtocol) {
        self.ids = ids
        self.remoteService = remoteService
    }
    
    /// Fetches appliances from the remote service using the appliance IDs.
    ///
    /// This method iterates through the list of appliance IDs, fetching each appliance from the remote
    /// service and updating the appliances dictionary when a response is received.
    func fetchAppliances() {
        for id in ids {
            remoteService
                .fetchAppliance(id)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error: \(error)")
                    case .finished:
                        print("Completed")
                    }
                }, receiveValue: { appliance in
                    self.appliances[appliance.applianceId] = appliance
                    print("Appliance: \(appliance)")
                })
                            .store(in: &bag)
        }
    }
}

/*
 class HomeViewModel: ObservableObject {
 
 // MARK: - Properties
 
 /// An ordered dictionary of appliances, with the appliance ID as the key.
 @Published var appliances: OrderedDictionary<String, Appliance> = [:]
 
 /// A list of appliance IDs used for fetching appliances from the remote service.
 let ids = ["12CFD"]
 
 /// A set of `AnyCancellable` objects for managing Combine subscriptions.
 var bag: Set<AnyCancellable> = []
 
 // MARK: - Methods
 
 /// Fetches appliances from the remote service using the appliance IDs.
 ///
 /// This method iterates through the list of appliance IDs, fetching each appliance from the remote
 /// service and updating the appliances dictionary when a response is received.
 func fetchAppliances() {
 for id in ids {
 RemoteService.shared
 .fetchAppliance(id)
 .receive(on: DispatchQueue.main)
 .sink(receiveCompletion: { completion in
 switch completion {
 case .failure(let error):
 print("Error: \(error)")
 case .finished:
 print("Completed")
 }
 }, receiveValue: { appliance in
 self.appliances[appliance.applianceId] = appliance
 print("Appliance: \(appliance)")
 })
 .store(in: &bag)
 }
 }
 }
 */
