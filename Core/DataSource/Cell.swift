//
//  Cell.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import Foundation

protocol Cell {
    static var reuseIdentifier: String { get }
}

extension Cell {
    static var reuseIdentifier: String { String(describing: Self.self) }
}
