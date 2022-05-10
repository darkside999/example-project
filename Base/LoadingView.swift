//
//  LoadingView.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit

final class LoadingView: View {
    lazy var loadingIndicator = UIActivityIndicatorView(style: .large)
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        makeConstraints()
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateStyle() {
        super.updateStyle()
        
        containerView.backgroundColor = isDarkMode ? UIColor.white.withAlphaComponent(0.7) : UIColor.black.withAlphaComponent(0.7)
        loadingIndicator.color = isDarkMode ? UIColor.black : .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        loadingIndicator.startAnimating()
    }
}

private extension LoadingView {
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(loadingIndicator)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 90),
            containerView.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
}

