//
//  HomeViewModel.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import Foundation
import OrderedCollections
import Combine

class HomeViewModel: ObservableObject {
    @Published var appliances: OrderedDictionary<String, Appliance> = [:]
    
    let ids = ["12CFD"]
    var bag: Set<AnyCancellable> = []
    
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
