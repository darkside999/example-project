//
//  ListChainsBuilder.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import Foundation
import UIKit

final class ListChainsBuilder {
    func build() -> UIViewController {
        let presenter = ListChainsPresenter()
        let interactor = ListChainsIntercator(presenter: presenter)
        let controller = ListChainsController(interactor: interactor)
        presenter.controller = controller
        return controller
    }
}
