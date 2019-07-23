//
//  CodableApiMethod.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import Foundation

class CodableAPIMethod<T: Codable>: APIMethod {

    private let parser: CodableDataParser<T>

    init(
        url: URL? = Defaults.baseURL,
        method: String,
        httpMethod: HTTPMethod = .get,
        headers: [String : String] = [:],
        queryParams: [String : String] = [:],
        bodyParams: [String : Any?] = [:],
        parser: CodableDataParser<T>)
    {
        self.parser = parser
        super.init(url: url, method: method, httpMethod: httpMethod, headers: headers, queryParams: queryParams, bodyParams: bodyParams)
    }

    func perform(_ completionBlock: (([T]?, URLResponse?, Error?) -> Void)?) {
        guard let request = request else {
            completionBlock?(nil, nil, ApiError.badRequestError)
            return
        }

        // create data task
        let dataTask = URLSession.shared.dataTask(with: request) { [parser, completionBlock] (data, response, error) in
            StatusBarLoader.default.update(false)
            let data = try? parser.parseData(data)
            completionBlock?(data, response, error)
        }

        StatusBarLoader.default.update(true)
        dataTask.resume()
    }

}
