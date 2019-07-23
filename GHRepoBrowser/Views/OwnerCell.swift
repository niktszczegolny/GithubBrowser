//
//  OwnerCell.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 22/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class OwnerCell: BasicCell {

    // first line
    private var topStackView = UIStackView()
    private var topDetailsStackView = UIStackView()
    private var avatarView = UIImageView()
    private var nameLabel = H1Label()
    private var typeLabel = H3Label()
    private var urlLabel = H3Label()

    // second line
    private var statsStackView = UIStackView()
    private var reposStackView = UIStackView()
    private var reposTitleLabel = H2Label()
    private var reposLabel = H1Label()
    private var followersStackView = UIStackView()
    private var followersTitleLabel = H2Label()
    private var followersLabel = H1Label()
    private var followingStackView = UIStackView()
    private var followingTitleLabel = H2Label()
    private var followingLabel = H1Label()

    // containers
    private var contentStackView = UIStackView()

    // public properties
    var viewModel: OwnerDetailsCellViewModeling? {
        didSet { fillWithData() }
    }

    override func setupUI() {
        super.setupUI()

        // default strings
        reposTitleLabel.text = "repos".localized
        followersTitleLabel.text = "followers".localized
        followingTitleLabel.text = "following".localized

        // constants
        let imageSize: CGFloat = 50.0
        let cornerRadius: CGFloat = 4.0
        let statsSpacing: CGFloat = 2.0
        let contentLinesSpacing: CGFloat = 16.0

        [nameLabel, typeLabel, urlLabel].forEach {
            $0.numberOfLines = 0
        }

        [topStackView, statsStackView].forEach {
            $0.spacing = Constants.viewsSpacing
        }

        avatarView.contentMode = .scaleAspectFill
        avatarView.layer.cornerRadius = cornerRadius
        avatarView.layer.masksToBounds = true
        avatarView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true

        topDetailsStackView.setArrangedSubviews([nameLabel, typeLabel, urlLabel])
        topDetailsStackView.axis = .vertical
        topDetailsStackView.spacing = Constants.viewsSpacing / 2.0

        topStackView.setArrangedSubviews([avatarView, topDetailsStackView])
        topStackView.axis = .horizontal
        topStackView.alignment = .center

        [reposLabel, reposTitleLabel, followersLabel, followersTitleLabel, followingLabel, followingTitleLabel].forEach {
            $0.textAlignment = .center
        }

        [(reposStackView, reposLabel, reposTitleLabel),
         (followersStackView, followersLabel, followersTitleLabel),
         (followingStackView, followingLabel, followingTitleLabel)].forEach {
            $0.0.setArrangedSubviews([$0.1, $0.2])
            $0.0.axis = .vertical
            $0.0.spacing = statsSpacing
        }

        statsStackView.setArrangedSubviews([reposStackView, followersStackView, followingStackView])
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillProportionally

        contentStackView.spacing = contentLinesSpacing
        contentStackView.setArrangedSubviews([topStackView, statsStackView])
        contentStackView.axis = .vertical

        contentView.addSubview(contentStackView)

        contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.innerMargin).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.innerMargin).isActive = true
        contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.innerMargin).isActive = true
        contentStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.innerMargin).isActive = true
    }

}

// MARK: Private

extension OwnerCell {

    private func fillWithData() {
        avatarView.image = nil
        avatarView.imageURL = viewModel?.avatarImageURL
        avatarView.isHidden = viewModel?.shouldDisplayAvatar == false
        nameLabel.text = viewModel?.name
        typeLabel.text = viewModel?.type
        urlLabel.text = viewModel?.userURL
        reposLabel.text = viewModel?.repos
        followersLabel.text = viewModel?.followers
        followingLabel.text = viewModel?.following
    }

}
