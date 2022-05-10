//
//  ListChainsDataFlow.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import Foundation

typealias ListChainsSection = Section<ListChainsSectionID>

enum ListChainsSectionID {
    case upcoming
    case past
}

struct BookingChains: Equatable {
    static func == (lhs: BookingChains, rhs: BookingChains) -> Bool {
        lhs.cityNames == rhs.cityNames && lhs.datePeriod.from == rhs.datePeriod.from && lhs.datePeriod.to == rhs.datePeriod.to && lhs.bookingsCount == rhs.bookingsCount
    }
    
    let cityNames: [String]
    let datePeriod: (from: Date, to: Date)
    let bookingsCount: Int
    let imageUrl: String
}

enum ListChainsState {
    case result([ListChainsSection])
    case error(String)
    case loading
}
