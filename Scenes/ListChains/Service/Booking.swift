//
//  Booking.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import Foundation

struct Hotel: Decodable {
    init(cityName: String, heroImageUrl: String) {
        self.cityName = cityName
        self.heroImageUrl = heroImageUrl
    }
    
    let cityName: String
    let heroImageUrl: String
    
    
}

struct Booking: Decodable {
    init(checkin: Date, checkout: Date, hotel: Hotel) {
        self.checkin = checkin
        self.checkout = checkout
        self.hotel = hotel
    }
    
    enum CodingKeys: String, CodingKey {
        case checkin
        case checkout
        case hotel
    }
    
    let checkin: Date
    let checkout: Date
    let hotel: Hotel
    
    init(from decoder: Decoder) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let checkinString = try container.decode(String.self, forKey: .checkin)
        self.checkin = dateFormatter.date(from: checkinString) ?? Date()
        let checkoutString = try container.decode(String.self, forKey: .checkout)
        self.checkout = dateFormatter.date(from: checkoutString) ?? Date()
        self.hotel = try container.decode(Hotel.self, forKey: .hotel)
    }
}

struct BookingsModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case bookings
    }
    
    let sortedBooking: [Booking]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let bookings = try container.decode([Booking].self, forKey: .bookings)
        self.sortedBooking = bookings.sorted(by: { $0.checkin < $1.checkin })
    }
    
    init(sortedBooking: [Booking]) {
        self.sortedBooking = sortedBooking
    }
    
    var upcomingAndPastChains: (upcoming: [BookingChains], past: [BookingChains]) {
        guard sortedBooking.isEmpty == false, let lastBooking = sortedBooking.last else { return (upcoming: [], past: []) }
        var upcomingChains: [BookingChains] = []
        var pastChains: [BookingChains] = []
        
        var chain: BookingChains = BookingChains(
            cityNames: [lastBooking.hotel.cityName],
            datePeriod: (from: lastBooking.checkin, to: lastBooking.checkout),
            bookingsCount: 1,
            imageUrl: lastBooking.hotel.heroImageUrl
        )
        
        let bookingsCount = sortedBooking.count
        let currentDate = Date()
        var indexStop: Int = -1
        
        if bookingsCount == 1 {
            if chain.datePeriod.to < currentDate {
                return (upcoming: [], past: [chain])
            } else if chain.datePeriod.from > currentDate {
                return (upcoming: [chain], past: [])
            } else {
                return (upcoming: [], past: [])
            }
        }
        
        for index in (0..<bookingsCount-1).reversed() {
            let booking = sortedBooking[index]
            
            // break when bookings date less than current
            if booking.checkin < currentDate, booking.checkout < currentDate {
                indexStop = index
                break
            } else if booking.checkin < currentDate {
                indexStop = index - 1
                break
            }
            
            if booking.checkout >= chain.datePeriod.from {
                chain = BookingChains(
                    cityNames: chain.cityNames + [booking.hotel.cityName],
                    datePeriod: (from: booking.checkin, to: chain.datePeriod.to),
                    bookingsCount: chain.bookingsCount + 1,
                    imageUrl: booking.hotel.heroImageUrl
                )
            } else {
                upcomingChains.append(chain)
                chain = BookingChains(
                    cityNames: [booking.hotel.cityName],
                    datePeriod: (from: booking.checkin, to: booking.checkout),
                    bookingsCount: 1,
                    imageUrl: booking.hotel.heroImageUrl
                )
            }
        }
        
        upcomingChains.append(chain)
        
        // look at the past bookings
        if indexStop >= 0 {
            chain = BookingChains(
                cityNames: [sortedBooking[indexStop].hotel.cityName],
                datePeriod: (from: sortedBooking[indexStop].checkin, to: sortedBooking[indexStop].checkout),
                bookingsCount: 1,
                imageUrl: sortedBooking[indexStop].hotel.heroImageUrl
            )
            
            for index in (0..<indexStop).reversed() {
                let booking = sortedBooking[index]

                if booking.checkout >= chain.datePeriod.from {
                    chain = BookingChains(
                        cityNames: chain.cityNames + [booking.hotel.cityName],
                        datePeriod: (from: booking.checkin, to: chain.datePeriod.to),
                        bookingsCount: chain.bookingsCount + 1,
                        imageUrl: booking.hotel.heroImageUrl
                    )
                } else {
                    pastChains.append(chain)
                    chain = BookingChains(
                        cityNames: [booking.hotel.cityName],
                        datePeriod: (from: booking.checkin, to: booking.checkout),
                        bookingsCount: 1,
                        imageUrl: booking.hotel.heroImageUrl
                    )
                }
            }
            
            pastChains.append(chain)
        }
        
        return (upcoming: upcomingChains, past: pastChains)
    }
}


