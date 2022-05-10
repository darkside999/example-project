//
//  Configurable.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import Foundation

typealias Configurable = AnyConfigurable & ConfigurableType

protocol AnyConfigurable {
    func configure(with model: Any)
}

protocol ConfigurableType {
    associatedtype Model
    func configure(with model: Model)
}

extension AnyConfigurable where Self: ConfigurableType {
    func configure(with model: Any) {
        guard let model = model as? Model else { return }
        configure(with: model)
    }
}
