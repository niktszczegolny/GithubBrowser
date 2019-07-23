//
//  License.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 22/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class License: Codable {

    var name: String?
    var url: String?
    var spdxId: String?

    enum CodingKeys: String, CodingKey {
        case name
        case url
        case spdxId = "spdx_id"
    }

}
