//
//  ImageView.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit
import BookingUI

// Here I use some of framework for loading images instead this, for example SDWebImage

class ImageViewCache {
    static let shared: ImageViewCache = .init()
    var caches: [URL: Data] = [:]
}

class ImageView: UIImageView {
    var currentUrl: URL?
    let dataStore: ImageViewCache = .shared
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "No Image"
        label.textColor = .gray
        label.font = BUI.Font.emphasized1.uiFont
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load(url: URL?) {
        guard let url = url else {
            return
        }
        
        currentUrl = url
        label.isHidden = true
        
        if let data = dataStore.caches[url] {
            self.image = UIImage(data: data)
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        guard self?.currentUrl == url else { return }
                        self?.image = image
                        self?.dataStore.caches[url] = data
                    } else {
                        self?.image = nil
                        self?.label.isHidden = false
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = nil
                    self?.label.isHidden = false
                }
            }
        }
    }
}
