//
//  RepoDetailsCellViewModel.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 22/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

protocol RepoDetailsCellViewModeling {
    var repository: Repository { get set }
    var name: String? { get }
    var description: String? { get }
    var startsString: String? { get }
    var forksString: String? { get }
    var createdAtString: String? { get }
    var updatedAtString: String? { get }
    var license: String? { get }
    var language: String? { get }
    var shouldDisplayDescription: Bool { get }
    var shouldDisplayStarsAndForks: Bool { get }
}

//MARK: Default Protocol implementation

extension RepoDetailsCellViewModeling {
    var description: String? { return repository.description }
    var startsString: String? { return repository.stars?.stringValue }
    var forksString: String? { return repository.forks?.stringValue }
    var shouldDisplayDescription: Bool { return description?.isEmpty == false }
    var shouldDisplayStarsAndForks: Bool { return startsString?.isEmpty == false || forksString?.isEmpty == false }
    var createdAtString: String? { return ["created at".localized, (repository.createdAt?.string(with: Date.DefaultDateFormat) ?? "-")].joined(separator: " ") }
    var updatedAtString: String? { return ["updated at".localized, (repository.updatedAt?.string(with: Date.DefaultDateFormat) ?? "-")].joined(separator: " ") }
    var license: String? { return ["license".localized, repository.license?.spdxId ?? "unknown".localized].joined(separator: " ") }
    var language: String? { return ["language".localized, repository.language ?? "unknown language".localized].joined(separator: " ") }
}

class RepoDetailsCellViewModel: RepoDetailsCellViewModeling {

    var name: String? { return repository.name }

    var repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }

}
