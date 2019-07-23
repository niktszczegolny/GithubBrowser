//
//  ApiMethod.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import Foundation

class APIMethod {

    // basic data
    private let url: URL?
    private let method: String
    private let httpMethod: HTTPMethod

    // headers and params
    private var headers: [String: String]
    private var queryParams: [String: String]
    private var bodyParams: [String: Any?]

    init(
        url: URL? = Defaults.baseURL,
        method: String,
        httpMethod: HTTPMethod = .get,
        headers: [String: String] = [:],
        queryParams: [String: String] = [:],
        bodyParams: [String: Any?] = [:])
    {
        self.url = url
        self.method = method
        self.httpMethod = httpMethod
        self.headers = headers
        self.queryParams = queryParams
        self.bodyParams = bodyParams
    }

}

// MARK: Create request

extension APIMethod {

    var request: URLRequest? {
        guard let url = url else { return nil }

        // create components to add path and items
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.path = method
        components?.queryItems = serializedQueryParams
        guard let componentsURL = components?.url else { return nil }

        // create request and fill with APIMethod data
        var request = URLRequest(url: componentsURL)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = serializedBody
        return request
    }

}

// MARK: Additional data

extension APIMethod {

    private var serializedBody: Data? {
        guard bodyParams.count > 0 else { return nil }
        return try? JSONSerialization.data(withJSONObject: bodyParams, options: [])
    }

    private var serializedQueryParams: [URLQueryItem]? {
        guard queryParams.count > 0 else { return nil }
        return queryParams.compactMap { return URLQueryItem(name: $0.key, value: $0.value) }
    }

}
