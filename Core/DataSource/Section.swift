//
//  Section.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import Foundation
import UIKit

struct Section<SectionID> {
    struct Appearance {
        let insets: UIEdgeInsets
        let minimumInteritemSpacing: CGFloat
        let minimumLineSpacing: CGFloat
    }
    
    let id: SectionID
    let elements: [Cell]
    let appearance: Appearance
}

