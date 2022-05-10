//
//  LabelCell.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit
import BookingUI

final class LabelCell: CollectionViewCell<LabelView> { }

struct LabelViewModel: Cell, Sizeable {
    let title: String
    
    var size: CGSize {
        let constrainedWidth: CGFloat = UIScreen.main.bounds.width - 32
        let titleHeight = title.height(withConstrainedWidth: constrainedWidth, font: BUI.Font.headline2.uiFont)
        return .init(width: UIScreen.main.bounds.width - 32, height: titleHeight)
    }
}

extension LabelView: Configurable {
    func configure(with model: LabelViewModel) {
        titleLabel.text = model.title
    }
}

final class LabelView: View {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = BUI.Font.headline2.uiFont
        label.textColor = BUI.Color.foreground.uiColor
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateStyle() {
        super.updateStyle()
        
        titleLabel.textColor = BUI.Color.foreground.uiColor
    }
}

private extension LabelView {
    func addSubviews() {
        addSubview(titleLabel)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}


