//
//  UICollectionView+Default.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit
import BookingUI

extension UICollectionView {
    static var `default`: UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }
}
