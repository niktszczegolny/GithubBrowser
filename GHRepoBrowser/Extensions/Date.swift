//
//  Date.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 23/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import Foundation

extension Date {

    static var DefaultDateFormat = "dd.MM.YYYY"

    func string(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

}
