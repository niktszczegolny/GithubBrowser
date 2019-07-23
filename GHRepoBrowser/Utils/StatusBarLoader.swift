//
//  StatusBarLoader.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 21/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class StatusBarLoader {

    static var `default` = StatusBarLoader()

    private var runsCount: Int = 0 {
        didSet { UIApplication.shared.isNetworkActivityIndicatorVisible = runsCount > 0 }
    }

    func update(_ state: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.runsCount += state ? 1 : -1
        }
    }

}
