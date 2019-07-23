//
//  DetailsCellViewModel.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 23/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

protocol DetailsCellViewModeling {
    var image: UIImage? { get }
    var imageBackgroundColor: UIColor? { get }
    var text: String? { get }
    var url: String? { get }
}

class DetailsCellViewModel: DetailsCellViewModeling {

    enum DetailType {
        case homepage
        case readme
        case license

        var image: UIImage? { return UIImage(named: String(describing: self))?.withRenderingMode(.alwaysTemplate) }
        var text: String? { return String(describing: self).localized }
        var color: UIColor? {
            switch self {
            case .homepage: return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            case .readme: return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            case .license: return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
        }
    }

    var image: UIImage? { return type.image }
    var imageBackgroundColor: UIColor? { return type.color }
    var text: String? { return type.text }
    private(set) var url: String?

    private var type: DetailType

    init(type: DetailType, url: String?) {
        self.type = type
        self.url = url
    }

}
