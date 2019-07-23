//
//  Readme.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 21/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class Readme: Codable {

    var htmlUrl: String

    enum CodingKeys: String, CodingKey {
        case htmlUrl = "html_url"
    }

}
