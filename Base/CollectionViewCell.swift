//
//  CollectionCell.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit

extension CollectionViewCell: Configurable where ContentView: Configurable {
    func configure(with model: ContentView.Model) {
        innerView.configure(with: model)
    }
}

class CollectionViewCell<ContentView: UIView>: UICollectionViewCell {
    lazy var innerView = ContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(innerView)
        
        innerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            innerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            innerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            innerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            innerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
