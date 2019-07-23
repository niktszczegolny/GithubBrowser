//
//  ReposCoordinator.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

protocol ReposCoordinating: Coordinating {
    var onCoordinatorFinished: (() -> Void)? { get set }
}

class ReposCoordinator: ReposCoordinating {
    
    // MARK: Public properties
    var rootViewController: UIViewController? { return navigationController }
    var onCoordinatorFinished: (() -> Void)?

    // MARK: Private properties
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    convenience init() {
        let navigationController = UINavigationController(
            navigationBarClass: UINavigationBar.self,
            toolbarClass: nil)
        self.init(navigationController: navigationController)
    }

    func start() {
        showReposViewController()
    }

}

// MARK: Private methods

extension ReposCoordinator {

    private func showReposViewController() {
        guard let viewController = createReposViewController() else { return }
        navigationController.setViewControllers([viewController], animated: false)
    }

    private func showRepoDetailsViewController(_ repo: Repository) {
        guard let viewController = createRepoDetailsViewController(repo) else { return }
        navigationController.pushViewController(viewController, animated: true)
    }

    private func createReposViewController() -> ReposListViewController? {
        let viewController = ReposListViewController()
        viewController.viewModel = ReposListViewModel()
        viewController.viewModel?.onViewModelFinished = { [weak self] in self?.onCoordinatorFinished?() }
        viewController.viewModel?.onSelectRepository = { [weak self] repo in self?.showRepoDetailsViewController(repo) }
        return viewController
    }

    private func createRepoDetailsViewController(_ repo: Repository) -> RepoDetailsViewController? {
        let viewController = RepoDetailsViewController()
        viewController.viewModel = RepoDetailsViewModel(repo: repo)
        return viewController
    }

}
