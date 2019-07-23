//
//  AppCoordinator.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinating {

    static let `default` = AppCoordinator()

    // MARK: Public properties
    var rootViewController: UIViewController? { return window.rootViewController }

    // MARK: Priavte Properties
    private let window: UIWindow
    private var coordinators: [String: Coordinating] = [:]

    init(window: UIWindow) {
        self.window = window
    }

    convenience init() {
        self.init(window: UIWindow(frame: UIScreen.main.bounds))
    }

    // MARK: Public API
    func start() {
        showViewController()
        window.makeKeyAndVisible()
    }

}

// MARK: Private methods

extension AppCoordinator {

    private func showViewController() {
        let coordinator: Coordinating = ReposCoordinator()
        coordinators[coordinator.name] = coordinator
        show(coordinator)
    }

    private func show(_ coordinator: Coordinating) {
        coordinator.start()
        window.setRootViewController(coordinator.rootViewController, animated: window.rootViewController != nil)
    }

}
