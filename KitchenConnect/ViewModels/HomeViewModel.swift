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

///
/// A view model for the `HomeView`.
///
/// This class handles fetching appliance data and managing the state of the view. It contains a dictionary
/// of appliances, which is updated when appliances are fetched from the remote service.
///
class HomeViewModel: ObservableObject, ErrorHandlable {

    // MARK: - Properties

    /// An ordered dictionary of appliances, with the appliance ID as the key.
    @Published var appliances: OrderedDictionary<String, Appliance> = [:]

    // A property to store the error that occurred. When an error occurs, it is assigned to this property
    // so that it can be displayed to the user.
    @Published var error: Error?

    // A Boolean property that determines whether the error alert is currently presented or not.
    // This property is used to control the presentation of the error alert view in SwiftUI.
    @Published var isErrorAlertPresented = false

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
                        self.showError(error: error)
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
