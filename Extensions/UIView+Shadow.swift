//
//  UIView+Shadow.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit
import BookingUI

extension UIView {
    func applyShadow(shadow: BUI.Shadow) {
        layer.shadowColor = shadow.color.uiColor.cgColor
        layer.shadowOffset = shadow.offset
        layer.shadowRadius = shadow.blur
        layer.shadowOpacity = Float(shadow.opacity)
    }
}
