//
//  UIVIew+Loading.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit

extension UIView {
    func setLoading() {
        let background = LoadingView()
        addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.centerXAnchor.constraint(equalTo: centerXAnchor),
            background.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        bringSubviewToFront(background)
    }
    
    func removeLoading() {
        subviews.first(where: { $0 is LoadingView })?.removeFromSuperview()
    }
}
