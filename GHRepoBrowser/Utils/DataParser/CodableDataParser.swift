//
//  CodableDataParser.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import Foundation

class CodableDataParser<T: Codable>: DataParser {

    typealias JSONObject = [AnyHashable: Any?]

    private var resultsKeyPath: String?

    init(resultsKeyPath: String? = nil) {
        self.resultsKeyPath = resultsKeyPath
    }

    // map JSON data to Codable objects
    func parseData(_ data: Any?) throws -> [T] {
        var objectDictionaries: [JSONObject] = []
        var deserialized: Any?

        if let rawData = data as? Data {
            deserialized = try JSONSerialization.jsonObject(with: rawData, options: [])
        } else {
            deserialized = data
        }

        // convert input data to array of dictionaries
        if let jsonDictionariesArray = deserialized as? [JSONObject] {
            objectDictionaries = jsonDictionariesArray
        } else if let jsonSingleDictionary = deserialized as? JSONObject {
            if let resultsKeyPath = resultsKeyPath {
                return try parseData(jsonSingleDictionary[resultsKeyPath])
            } else {
                objectDictionaries = [jsonSingleDictionary]
            }
        }

        guard let parsedObjects = try [T](withJSONObject: objectDictionaries) else {
            return []
        }

        return parsedObjects
    }

}

