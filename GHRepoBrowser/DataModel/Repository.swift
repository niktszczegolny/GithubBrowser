//
//  Repository.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import Foundation

class Repository: Codable {

    var id: Int
    var name: String
    var fullName: String?
    var owner: Owner
    var description: String?
    var url: String?
    var htmlUrl: String?
    var forks: Int?
    var stars: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var language: String?
    var license: License?
    var homepage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case description
        case url
        case htmlUrl = "html_url"
        case forks
        case stars = "watchers"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case language
        case license
        case homepage
    }

}
