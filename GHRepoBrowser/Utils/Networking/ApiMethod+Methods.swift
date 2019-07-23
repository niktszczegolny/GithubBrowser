//
//  ApiMethod+Methods.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import Foundation

extension APIMethod {

    /**
     Search for specific repo
     */
    static func getRepos(_ query: String? = nil, page: Int = 0) -> CodableAPIMethod<Repository> {
        var params = ["page": "\(page)", "per_page": "\(Defaults.defaultPageSize)"]
        guard let query = query, query.isEmpty == false else {
            params["since"] = "\(Defaults.firstPublicRepoIndex)"
            return CodableAPIMethod(method: "/repositories", httpMethod: .get, queryParams: params, parser: CodableDataParser())
        }

        // append query param
        params["q"] = query
        return CodableAPIMethod(method: "/search/repositories", httpMethod: .get, queryParams: params, parser: CodableDataParser(resultsKeyPath: "items"))
    }

    /**
     Get repository details
     */
    static func getRepoDetails(repo: Repository) -> CodableAPIMethod<Repository> {
        return CodableAPIMethod(method: "/repos/\(repo.owner.login)/\(repo.name)", httpMethod: .get, parser: CodableDataParser())
    }

    /**
     Get repository README.MD
     */
    static func getRepoReadme(repo: Repository) -> CodableAPIMethod<Readme> {
        return CodableAPIMethod(method: "/repos/\(repo.owner.login)/\(repo.name)/readme", httpMethod: .get, parser: CodableDataParser())
    }

    /**
     Get user details
     */
    static func getUserDetails(user: Owner) -> CodableAPIMethod<Owner> {
        return CodableAPIMethod(method: "/users/\(user.login)", httpMethod: .get, parser: CodableDataParser())
    }

}
