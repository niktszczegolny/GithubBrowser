//
//  UIFont.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

extension UIFont {

    private static func defaultFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.trebuchet?.ofSize(size) ?? .systemFont(ofSize: size)
    }

    func ofSize(_ size: CGFloat) -> UIFont? {
        return UIFont(name: fontName, size: size)
    }

    static let h0: UIFont = .defaultFont(ofSize: 30.0)
    static let h1: UIFont = .defaultFont(ofSize: 16.0)
    static let h2: UIFont = .defaultFont(ofSize: 14.0)
    static let h3: UIFont = .defaultFont(ofSize: 12.0)
}

extension UIFont {

    static let trebuchet: UIFont? = UIFont(name: "TrebuchetMS", size: 12.0)

    func styled(_ style: FontStyle) -> UIFont {
        let baseName = FontStyle.removeStyle(from: fontName)
        let name: String = baseName + "-" + style.suffixValue
        return UIFont(name: name, size: pointSize) ?? self
    }

}

enum FontStyle {
    case bold
    case italic

    var suffixValue: String {
        switch self {
        case .bold: return "Bold"
        case .italic: return "Italic"
        }
    }

    private static var allStyles: [FontStyle] {
        return [.bold, .italic]
    }

    static func removeStyle(from fontName: String) -> String {
        var finalName = fontName
        for suffix in (allStyles.map { "-" + $0.suffixValue }) {
            finalName = finalName.replacingOccurrences(of: suffix, with: "")
        }
        return finalName
    }
}
