//
//  EmptyView.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 23/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    private var stackView = UIStackView()
    private var imageView = UIImageView(image: UIImage(named: "empty-view"))
    private var titleLabel = BasicLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        let margin: CGFloat = 64.0
        let spacing: CGFloat = 16.0

        imageView.contentMode = .scaleAspectFit
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = "empty view".localized
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont.h1.styled(.italic)

        stackView.setArrangedSubviews([imageView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = spacing

        addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: margin).isActive = true
        stackView.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: margin).isActive = true
    }

}
