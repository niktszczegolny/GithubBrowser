//
//  ReadmeCellViewModel.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 22/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

protocol ReadmeCellViewModeling {
    var readme: Readme { get set }
    var attributedText: NSAttributedString? { get }
}

class ReadmeCellViewModel: ReadmeCellViewModeling {

    var readme: Readme
    var attributedText: NSAttributedString? {
        guard let url = URL.init(string: readme.htmlUrl) else { return nil }
        guard let htmlData = try? Data(contentsOf: url) else { return nil }
        return try? NSAttributedString(
            data: htmlData,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
    }

    init(readme: Readme) {
        self.readme = readme
    }

}
