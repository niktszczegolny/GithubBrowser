//
//  OwnerDetailsCellViewModel.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 22/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

protocol OwnerDetailsCellViewModeling {
    var owner: Owner { get set }
    var avatarImageURL: String? { get }
    var name: String? { get }
    var userURL: String? { get }
    var type: String? { get }
    var repos: String { get }
    var followers: String { get }
    var following: String { get }
    var shouldDisplayAvatar: Bool { get }
}

//MARK: Default Protocol implementation

extension OwnerDetailsCellViewModeling {
    var avatarImageURL: String? { return owner.avatarUrl }
    var userURL: String? { return owner.url }
    var type: String? { return owner.type }
    var repos: String { return owner.repos?.stringValue ?? "-" }
    var followers: String { return owner.followers?.stringValue ?? "-" }
    var following: String { return owner.following?.stringValue ?? "-" }
    var shouldDisplayAvatar: Bool { return avatarImageURL != nil }
}

class OwnerDetailsCellViewModel: OwnerDetailsCellViewModeling {

    var name: String? { return owner.login }
    var owner: Owner

    init(owner: Owner) {
        self.owner = owner
    }

}
