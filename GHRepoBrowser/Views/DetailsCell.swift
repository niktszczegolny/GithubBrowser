//
//  DetailsCell.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 23/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class DetailsCell: BasicCell {

    private var stackView = UIStackView()
    private var detailImageView = UIImageView()
    private var titleLabel = H1Label()

    // public properties
    var viewModel: DetailsCellViewModeling? {
        didSet { fillWithData() }
    }

    override func setupUI() {
        super.setupUI()

        // constants
        let imageSize: CGFloat = 24.0
        let spacing: CGFloat = 8.0

        detailImageView.contentMode = .scaleAspectFill
        detailImageView.layer.cornerRadius = imageSize / 2.0
        detailImageView.layer.masksToBounds = true
        detailImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true

        stackView.spacing = spacing
        stackView.setArrangedSubviews([detailImageView, titleLabel])
        stackView.axis = .horizontal

        contentView.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.innerMargin).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.innerMargin).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.innerMargin).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.innerMargin).isActive = true

    }

}

// MARK: Private

extension DetailsCell {

    private func fillWithData() {
        detailImageView.image = viewModel?.image
        titleLabel.text = viewModel?.text
        detailImageView.tintColor = viewModel?.imageBackgroundColor
    }

}

