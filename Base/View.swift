//
//  View.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit
import BookingUI

class View: UIView {
    var isDarkMode: Bool { traitCollection.userInterfaceStyle == .dark }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
    }
}
