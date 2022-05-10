//
//  StyleConfigurator.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit
import BookingUI

struct StyleConfigurator: Configurator {
    func configure() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = BUI.Color.backgroundBase.uiColor
        appearance.titleTextAttributes = [
            .font: BUI.Font.body1,
            .foregroundColor: BUI.Color.foreground
        ]
        appearance.shadowImage = nil
        appearance.backgroundImage = nil
        appearance.shadowColor = nil
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
