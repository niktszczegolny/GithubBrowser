//
//  RepoCell.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class RepoCell: BasicCell {

    // first line
    private var topTitleStackView = UIStackView()
    private var avatarView = UIImageView()
    private var fullNameLabel = H1Label()

    // second line
    private var descriptionLabel = H2Label()

    // third line
    private var bottomDetailsStackView = UIStackView()
    private var starView = UIImageView()
    private var starLabel = H2Label()
    private var forkView = UIImageView()
    private var forkLabel = H2Label()

    // containers
    private var borderedContentView = UIView()
    private var contentStackView = UIStackView()

    // public properties
    var viewModel: RepoCellViewModeling? {
        didSet {
            viewModel?.onReloadData = { [weak self] in
                self?.fillWithData()
            }
            fillWithData()
        }
    }

    override func setupUI() {
        super.setupUI()
        fillWithData()
        
        // constants
        let imageSize: CGFloat = 24.0
        let smallImageSize: CGFloat = 20.0
        let cornerRadius: CGFloat = 4.0

        [fullNameLabel, descriptionLabel].forEach {
            $0.numberOfLines = 0
        }

        [contentStackView, topTitleStackView, bottomDetailsStackView].forEach {
            $0.spacing = Constants.viewsSpacing
        }

        [(avatarView, imageSize), (starView, smallImageSize), (forkView, smallImageSize)].forEach {
            $0.0.widthAnchor.constraint(equalToConstant: $0.1).isActive = true
            //$0.0.heightAnchor.constraint(equalToConstant: $0.1).isActive = true
        }

        // set default images
        forkView.image = UIImage(named: "fork")?.withRenderingMode(.alwaysTemplate)
        starView.image = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        [forkView, starView].forEach {
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .darkGray
        }

        avatarView.contentMode = .scaleAspectFill
        avatarView.layer.cornerRadius = cornerRadius
        avatarView.layer.masksToBounds = true

        // content view appearance
        borderedContentView.translatesAutoresizingMaskIntoConstraints = false
        borderedContentView.layer.borderColor = UIColor.lightGray.cgColor
        borderedContentView.layer.borderWidth = 1.0 / UIScreen.main.scale
        borderedContentView.layer.cornerRadius = cornerRadius

        topTitleStackView.setArrangedSubviews([avatarView, fullNameLabel])
        topTitleStackView.axis = .horizontal
        topTitleStackView.alignment = .center
        bottomDetailsStackView.setArrangedSubviews([starView, starLabel, forkView, forkLabel])
        bottomDetailsStackView.axis = .horizontal
        bottomDetailsStackView.alignment = .center
        contentStackView.setArrangedSubviews([topTitleStackView, descriptionLabel, bottomDetailsStackView])
        contentStackView.axis = .vertical

        starLabel.widthAnchor.constraint(equalTo: forkLabel.widthAnchor, multiplier: 1.0).isActive = true

        borderedContentView.addSubview(contentStackView)
        contentView.addSubview(borderedContentView)

        [(borderedContentView, contentStackView, Constants.innerMargin), (contentView, borderedContentView, Constants.innerMargin)].forEach {
            $0.1.topAnchor.constraint(equalTo: $0.0.topAnchor, constant: $0.2).isActive = true
            $0.1.bottomAnchor.constraint(equalTo: $0.0.bottomAnchor, constant: -$0.2).isActive = true
            $0.1.leftAnchor.constraint(equalTo: $0.0.leftAnchor, constant: $0.2).isActive = true
            $0.1.rightAnchor.constraint(equalTo: $0.0.rightAnchor, constant: -$0.2).isActive = true
        }
    }

}

// MARK: Private

extension RepoCell {

    private func fillWithData() {
        avatarView.image = nil
        avatarView.imageURL = viewModel?.avatarImageURL
        avatarView.isHidden = viewModel?.shouldDisplayAvatar == false
        fullNameLabel.attributedText = viewModel?.fullName ?? NSAttributedString(string: " ")
        descriptionLabel.text = viewModel?.description ?? " "
        descriptionLabel.isHidden = viewModel?.shouldDisplayDescription == false
        starLabel.text = viewModel?.startsString ?? " "
        forkLabel.text = viewModel?.forksString ?? " "
        bottomDetailsStackView.isHidden = viewModel?.shouldDisplayStarsAndForks == false
    }

}
