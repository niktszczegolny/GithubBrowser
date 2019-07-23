//
//  Owner.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import Foundation

class Owner: Codable {

    var id: Int
    var login: String
    var avatarUrl: String?
    var url: String?
    var reposUrl: String?
    var htmlUrl: String?
    var type: String?
    var repos: Int?
    var followers: Int?
    var following: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case url
        case reposUrl = "repos_url"
        case htmlUrl = "html_url"
        case type
        case repos = "public_repos"
        case followers
        case following
    }

}
