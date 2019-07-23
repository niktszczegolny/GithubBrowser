//
//  RepoCellViewModel.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

protocol RepoCellViewModeling: RepoDetailsCellViewModeling, OwnerDetailsCellViewModeling {
    var fullName: NSAttributedString? { get }
    var onReloadData: (() -> Void)? { get set }
}

class RepoCellViewModel: RepoCellViewModeling {

    var name: String? { return repository.name }
    var fullName: NSAttributedString? {
        guard let fullName = repository.fullName else { return nil }
        let attrName = NSMutableAttributedString(string: fullName)

        // set repo name BOLD
        if let nameRange = fullName.range(of: repository.name, options: .backwards) {
            let nsRange = NSRange(nameRange, in: fullName)
            attrName.addAttributes([.font: UIFont.h1.styled(.bold)], range: nsRange)
        }

        return attrName
    }
    
    var onReloadData: (() -> Void)?

    var repository: Repository
    var owner: Owner

    init(repository: Repository) {
        self.repository = repository
        self.owner = repository.owner
    }

}
