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

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response."
        case .invalidData:
            return "Invalid data."
        }
    }
}

class RemoteService {
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
}
