//
//  CollectionDataSource.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import Foundation
import UIKit

class CollectionDataSource<SectionID>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var sections: [Section<SectionID>] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].elements.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = sections[indexPath.section].elements[indexPath.item]
        let typeModel = type(of: cellModel)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: typeModel.reuseIdentifier, for: indexPath)
        
        if let configurable = cell as? AnyConfigurable {
            configurable.configure(with: cellModel)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let sizeable = sections[indexPath.section].elements[indexPath.item] as? Sizeable else { return .zero }
        return sizeable.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sections[section].appearance.insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sections[section].appearance.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sections[section].appearance.minimumInteritemSpacing
    }
}
