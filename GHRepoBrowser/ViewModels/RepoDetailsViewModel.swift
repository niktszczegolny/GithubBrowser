//
//  RepoDetailsViewModel.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

protocol RepoDetailsViewModeling: ViewControllerModeling, UITableViewDataSource, UITableViewDelegate {
    var onReloadData: (() -> Void)? { get set }
    var onLoadingStateChange: ((Bool) -> Void)? { get set }
    func getRepoDetails()
}

class RepoDetailsViewModel: NSObject, RepoDetailsViewModeling {
    
    var title: String { return repo.name }
    var onReloadData: (() -> Void)?

    // refresh right after update value
    var onLoadingStateChange: ((Bool) -> Void)? {
        didSet { onLoadingStateChange?(isLoading) }
    }

    private var repo: Repository
    private var owner: Owner
    private var readme: Readme?
    private var detailViewModels: [DetailsCellViewModel] = []

    private var isLoading: Bool = false {
        didSet {
            if isLoading != oldValue {
                onLoadingStateChange?(isLoading)
            }
        }
    }

    init(repo: Repository) {
        self.repo = repo
        self.owner = repo.owner
        super.init()
        getRepoDetails()
    }

    func getRepoDetails() {
        // simple responses counter
        var responsesCount = 3
        let performReload = { [weak self] in
            responsesCount -= 1
            guard responsesCount == 0 else { return }
            self?.onReloadData?()
            self?.isLoading = false
            self?.detailViewModels = []
            if let url = self?.repo.homepage { self?.detailViewModels.append(DetailsCellViewModel(type: .homepage, url: url)) }
            if let url = self?.repo.license?.url { self?.detailViewModels.append(DetailsCellViewModel(type: .license, url: url)) }
            if let url = self?.readme?.htmlUrl { self?.detailViewModels.append(DetailsCellViewModel(type: .readme, url: url)) }
        }

        isLoading = true

        APIMethod.getRepoDetails(repo: repo).perform { [weak self] (repos, response, error) in
            guard let repo = repos?.first else {
                performReload()
                return
            }
            self?.repo = repo
            performReload()
        }

        APIMethod.getRepoReadme(repo: repo).perform { [weak self] (readmes, response, error) in
            self?.readme = readmes?.first
            performReload()
        }

        APIMethod.getUserDetails(user: repo.owner).perform { [weak self] (owners, response, error) in
            guard let owner = owners?.first else {
                performReload()
                return
            }
            self?.owner = owner
            performReload()
        }
    }
    
}

// MARK: Table View Data Source & Delegate

extension RepoDetailsViewModel {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 + (readme != nil ? 1 : 0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2: return detailViewModels.count
        default: return 1
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: OwnerCell = tableView.dequeueReusableCell() else { return UITableViewCell() }
            cell.viewModel = OwnerDetailsCellViewModel(owner: owner)
            cell.setLoading(isLoading)
            return cell
        case 1:
            guard let cell: RepoDetailsCell = tableView.dequeueReusableCell() else { return UITableViewCell() }
            cell.viewModel = RepoDetailsCellViewModel(repository: repo)
            cell.setLoading(isLoading)
            return cell
        case 2:
            guard let cell: DetailsCell = tableView.dequeueReusableCell() else { return UITableViewCell() }
            cell.viewModel = detailViewModels[safe: indexPath.row]
            cell.accessoryType = .disclosureIndicator
            cell.setLoading(isLoading)
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0: open(owner.htmlUrl)
        case 1: open(repo.htmlUrl)
        case 2: open(detailViewModels[safe: indexPath.row]?.url)
        default: break
        }
    }

}

// MARK: Private

extension RepoDetailsViewModel {

    private func open(_ urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
