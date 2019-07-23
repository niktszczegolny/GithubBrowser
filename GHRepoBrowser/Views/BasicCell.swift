//
//  BasicCell.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 22/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell {

    class Constants {
        // constants
        static let innerMargin: CGFloat = 8.0
        static let viewsSpacing: CGFloat = 8.0
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    func setupUI() {
        // abstract

    }

    func setLoading(_ loading: Bool) {
        let labels: [BasicLabel] = contentView.typedSubviews()
        let imageViews: [UIImageView] = contentView.typedSubviews()

        labels.forEach { $0.setShimmering(loading) }
        imageViews.forEach { $0.setShimmering(loading) }
    }

}
