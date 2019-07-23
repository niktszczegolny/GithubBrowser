//
//  Decodable.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import Foundation

extension Decodable {
    init?(withJSONData jsonData: Data?) throws {
        guard let data = jsonData else {
            return nil
        }

        self = try JSONDDateFixedDecoder.default.decode(Self.self, from: data)
    }

    init?(withJSONObject json: Any) throws {
        try self.init(withJSONData: try? JSONSerialization.data(withJSONObject: json, options: []))
    }
}

private class JSONDDateFixedDecoder: JSONDecoder {

    private static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()

    static var `default`: JSONDDateFixedDecoder {
        let decoder = JSONDDateFixedDecoder()
        decoder.dateDecodingStrategy = .custom({ decoder -> Date in
            // Get the string date
            let dateString = try decoder
                .singleValueContainer()
                .decode(String.self)

            guard let date = formatter.date(from: dateString) else {
                throw NSError(domain: "com.ap.GHRepoBrowser", code: -10000, userInfo: nil)
            }

            return date
        })
        return decoder
    }

}
