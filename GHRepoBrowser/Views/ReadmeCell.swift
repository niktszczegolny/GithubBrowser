//
//  ReadmeCell.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 22/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class ReadmeCell: BasicCell {

    private var textView = UITextView()

    // public properties
    var viewModel: ReadmeCellViewModeling? {
        didSet { fillWithData() }
    }

    override func setupUI() {
        super.setupUI()

        textView.isEditable = false
        textView.isScrollEnabled = false

        contentView.addSubview(textView)

        textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.innerMargin).isActive = true
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.innerMargin).isActive = true
        textView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.innerMargin).isActive = true
        textView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.innerMargin).isActive = true
    }

}

// MARK: Private

extension ReadmeCell {

    private func fillWithData() {
        textView.attributedText = viewModel?.attributedText
    }

}
