//
//  UIStackView.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

extension UIStackView {

    func setArrangedSubviews(_ views: [UIView]) {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        views.forEach { addArrangedSubview($0) }
    }

}
