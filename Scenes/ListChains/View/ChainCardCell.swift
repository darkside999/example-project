//
//  ChainCardCell.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit
import BookingUI

fileprivate let imageHeight = (UIScreen.main.bounds.width - 32) * 9 / 16

final class ChainCardCell: CollectionViewCell<ChainCardView> { }

struct ChainCardViewModel: Cell, Sizeable {
    let title: String
    let subtitle: String
    let imageUrl: String
    
    var size: CGSize {
        let verticalInsets: CGFloat = imageHeight + 40
        let constrainedWidth: CGFloat = UIScreen.main.bounds.width - 64
        
        let titleHeight: CGFloat = title.height(withConstrainedWidth: constrainedWidth, font: BUI.Font.headline3.uiFont)
        let subtitleHeight: CGFloat = subtitle.height(withConstrainedWidth: constrainedWidth, font: BUI.Font.body2.uiFont)
        
        return .init(width: UIScreen.main.bounds.width - 32, height: verticalInsets + titleHeight + subtitleHeight)
    }
}

extension ChainCardView: Configurable {
    func configure(with model: ChainCardViewModel) {
        titleLabel.text = model.title
        subTitleLabel.text = model.subtitle
        imageView.load(url: URL(string: model.imageUrl))
    }
}

final class ChainCardView: View {
    lazy var imageView: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = BUI.borderRadius200
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = BUI.Font.headline3.uiFont
        label.textColor = BUI.Color.foreground.uiColor
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = BUI.Font.body2.uiFont
        label.textColor = BUI.Color.foreground.uiColor
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        makeConstraints()
        
        applyShadow(shadow: .shadow100)
        layer.cornerRadius = BUI.borderRadius200
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateStyle() {
        super.updateStyle()
        
        titleLabel.textColor = BUI.Color.foreground.uiColor
        subTitleLabel.textColor = BUI.Color.foreground.uiColor
        backgroundColor = BUI.Color.backgroundElevationTwo.uiColor
    }
}

private extension ChainCardView {
    func addSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}


