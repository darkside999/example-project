//
//  ViewController.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit
import BookingUI

class ViewController: UIViewController {
    var isDarkMode: Bool { traitCollection.userInterfaceStyle == .dark }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        updateStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        updateStyle()
    }
    
    func updateStyle() {
        let appearance = UINavigationBar.appearance().standardAppearance
        appearance.backgroundColor = BUI.Color.backgroundBase.uiColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
