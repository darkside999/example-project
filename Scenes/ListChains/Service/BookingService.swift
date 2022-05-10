//
//  BookingService.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import Foundation
import BookingService

protocol BookingService {
    func fetchBookings(userId: Int, completion: @escaping (Result<BookingsModel, Error>) -> Void)
}

struct RealBookingService: BookingService {
    let network: Network
    let decoder: JSONDecoder
    
    internal init(network: Network = .init(), decoder: JSONDecoder = JSONDecoder()) {
        self.network = network
        self.decoder = decoder
    }
    
    func fetchBookings(userId: Int, completion: @escaping (Result<BookingsModel, Error>) -> Void) {
        network.fetchBookings(userId: 899848) { result in
            switch result {
            case .success(let data):
                do {
                    let model = try self.decoder.decode(BookingsModel.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
