//
//  UISearchBar.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 21/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

extension UISearchBar {

    private var textField: UITextField? {
        let textFields: [UITextField] = typedSubviews()
        return textFields.first
    }

    private var searchIcon: UIImage? {
        let imageViews: [UIImageView] = typedSubviews()
        return imageViews.first?.image
    }

    private var activityIndicator: UIActivityIndicatorView? {
        let activityIndicatorViews: [UIActivityIndicatorView] = typedSubviews()
        return activityIndicatorViews.first
    }

    // little bit tricky
    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                if newValue {
                    if self.activityIndicator == nil {
                        let activityIndicator = UIActivityIndicatorView(style: .gray)
                        activityIndicator.startAnimating()
                        self.setImage(UIImage(), for: .search, state: .normal)
                        self.textField?.leftView?.addSubview(activityIndicator)
                        let leftViewSize = self.textField?.leftView?.frame.size ?? .zero
                        activityIndicator.center = CGPoint(x: leftViewSize.width / 2.0, y: leftViewSize.height / 2.0)
                    }
                } else {
                    self.setImage(self.searchIcon, for: .search, state: .normal)
                    self.activityIndicator?.removeFromSuperview()
                }
            }
        }
    }
}
