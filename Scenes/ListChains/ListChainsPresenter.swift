//
//  ListChainsPresenter.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import Foundation

protocol ListChainsPresentationLogic: AnyObject {
    func presentList(result: Result<BookingsModel, Error>)
}

final class ListChainsPresenter: ListChainsPresentationLogic {
    weak var controller: ListChainsDisplayLogic?
    
    func presentList(result: Result<BookingsModel, Error>) {
        switch result {
        case .success(let model):
            controller?.displayState(.result(transform(from: model)))
        case .failure(let error):
            controller?.displayState(.error(error.localizedDescription))
        }
    }
    
    func transform(from model: BookingsModel) -> [ListChainsSection] {
        let upcomingModels: [ChainCardViewModel] = model.upcomingAndPastChains.upcoming.map(map(_:))
        let pastModels: [ChainCardViewModel] = model.upcomingAndPastChains.past.map(map(_:))
        
        let upcomingLabel = LabelViewModel(title: "Upcoming trips")
        let pastLabel = LabelViewModel(title: "Past trips")
        
        let upcomingSection = ListChainsSection(id: .upcoming, elements: [upcomingLabel] + upcomingModels,
                                                appearance: .init(insets: .init(top: 32, left: 16, bottom: pastModels.isEmpty ? 32 : 0, right: 16), minimumInteritemSpacing: 0, minimumLineSpacing: 16))
        let pastSection = ListChainsSection(id: .past, elements: [pastLabel] + pastModels,
                                            appearance: .init(insets: .init(top: upcomingModels.isEmpty ? 32 : 16, left: 16, bottom: 32, right: 16), minimumInteritemSpacing: 0, minimumLineSpacing: 16))
        return (upcomingModels.isEmpty ? [] : [upcomingSection]) + (pastModels.isEmpty ? [] : [pastSection])
    }
    
    func map(_ chains: BookingChains) -> ChainCardViewModel {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        
        let fromComponents = calendar.dateComponents([.year, .month, .day], from: chains.datePeriod.from)
        let toComponents = calendar.dateComponents([.year, .month, .day], from: chains.datePeriod.to)
        
        let dateString: String
        if fromComponents.year == toComponents.year && fromComponents.month == toComponents.month {
            dateFormatter.dateFormat = "MMM yyyy"
            dateString = "\(fromComponents.day ?? 0)-\(toComponents.day ?? 0) \(dateFormatter.string(from: chains.datePeriod.from))"
        } else if fromComponents.year == toComponents.year {
            dateFormatter.dateFormat = "dd MMM"
            dateString = "\(dateFormatter.string(from: chains.datePeriod.from))-\(dateFormatter.string(from: chains.datePeriod.to)) \(fromComponents.year ?? 0)"
        } else {
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateString = "\(dateFormatter.string(from: chains.datePeriod.from))-\(dateFormatter.string(from: chains.datePeriod.to))"
        }
        
        let bookingsString = String.localizedStringWithFormat(NSLocalizedString("bookings count", comment: ""), chains.bookingsCount)
        let subtitle = dateString + "\n\(bookingsString)"
        
        return ChainCardViewModel(title: "Trip to " + chains.cityNames.joined(separator: ", "), subtitle: subtitle, imageUrl: chains.imageUrl)
    }
}
