//
//  Coordinator.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

protocol Coordinating {
    var rootViewController: UIViewController? { get }
    var name: String { get }
    func start()
}

extension Coordinating {
    var name: String { return String(describing: self) }
}
