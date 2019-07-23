//
//  RepoDetailsCell.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 22/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class RepoDetailsCell: BasicCell {

    // top lines
    private var nameLabel = H0Label()

    // short details lines
    private var detailsStackView = UIStackView()
    private var descriptionLabel = H2Label()
    private var languageLabel = H3Label()
    private var licenseLabel = H3Label()
    private var createdAtLabel = H3Label()
    private var updatedAtLabel = H3Label()

    // bottom line
    private var bottomDetailsStackView = UIStackView()
    private var starView = UIImageView()
    private var starLabel = H2Label()
    private var forkView = UIImageView()
    private var forkLabel = H2Label()

    // containers
    private var contentStackView = UIStackView()

    // public properties
    var viewModel: RepoDetailsCellViewModeling? {
        didSet { fillWithData() }
    }

    override func setupUI() {
        super.setupUI()

        // constants
        let imageSize: CGFloat = 20.0
        let detailsSpacing: CGFloat = 2.0

        [nameLabel, descriptionLabel].forEach {
            $0.numberOfLines = 0
        }

        [contentStackView, bottomDetailsStackView].forEach {
            $0.spacing = Constants.viewsSpacing
        }

        [(starView, imageSize), (forkView, imageSize)].forEach {
            $0.0.widthAnchor.constraint(equalToConstant: $0.1).isActive = true
        }

        // set default images
        forkView.image = UIImage(named: "fork")?.withRenderingMode(.alwaysTemplate)
        starView.image = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        [forkView, starView].forEach {
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .darkGray
        }

        detailsStackView.setArrangedSubviews([descriptionLabel, languageLabel, createdAtLabel, updatedAtLabel, licenseLabel])
        detailsStackView.axis = .vertical
        detailsStackView.spacing = detailsSpacing
        bottomDetailsStackView.setArrangedSubviews([starView, starLabel, forkView, forkLabel])
        bottomDetailsStackView.axis = .horizontal
        bottomDetailsStackView.alignment = .center
        contentStackView.setArrangedSubviews([nameLabel, detailsStackView, bottomDetailsStackView])
        contentStackView.axis = .vertical

        starLabel.widthAnchor.constraint(equalTo: forkLabel.widthAnchor, multiplier: 1.0).isActive = true

        contentView.addSubview(contentStackView)

        contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.innerMargin).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.innerMargin).isActive = true
        contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.innerMargin).isActive = true
        contentStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.innerMargin).isActive = true
    }

}

// MARK: Private

extension RepoDetailsCell {

    private func fillWithData() {
        nameLabel.text = viewModel?.name
        descriptionLabel.text = viewModel?.description
        descriptionLabel.isHidden = viewModel?.shouldDisplayDescription == false
        createdAtLabel.text = viewModel?.createdAtString
        updatedAtLabel.text = viewModel?.updatedAtString
        starLabel.text = viewModel?.startsString
        forkLabel.text = viewModel?.forksString
        licenseLabel.text = viewModel?.license
        languageLabel.text = viewModel?.language
    }

}
