//
//  DataParser.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import Foundation

protocol DataParser {
    associatedtype DataParserResultType
    func parseData(_ data: Any?) throws -> [DataParserResultType]
}
