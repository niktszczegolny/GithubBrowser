//
//  AppAppearance.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class AppAppearance {

    class func apply() {
        // UINavigationBar
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.h1,
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]
        UINavigationBar.appearance().tintColor = .lightGray
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.h0,
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]

        // Labels
        H0Label.appearance().customFont = .h0
        H1Label.appearance().customFont = .h1
        H2Label.appearance().customFont = .h2
        H3Label.appearance().customFont = .h3
        H1Label.appearance().customColor = .darkGray
        H2Label.appearance().customColor = .darkGray
        H3Label.appearance().customColor = .gray

        // Views
        BasicLabel.appearance().translatesAutoresizingMaskIntoConstraints = false
        UIImageView.appearance().translatesAutoresizingMaskIntoConstraints = false
        UIStackView.appearance().translatesAutoresizingMaskIntoConstraints = false
        UITextView.appearance().translatesAutoresizingMaskIntoConstraints = false
    }

}
