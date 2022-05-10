//
//  ListChainsIntercator.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import Foundation
import BookingService

protocol ListChainsBusinessLogic: AnyObject {
    func fetchList()
}

final class ListChainsIntercator: ListChainsBusinessLogic {
    let presenter: ListChainsPresentationLogic
    let service: BookingService
    
    internal init(presenter: ListChainsPresentationLogic, service: BookingService = RealBookingService()) {
        self.presenter = presenter
        self.service = service
    }
    
    func fetchList() {
        // 899848, 48098, 8984747, 5678923
        service.fetchBookings(userId: 899848) { result in
            self.presenter.presentList(result: result)
        }
    }
}
