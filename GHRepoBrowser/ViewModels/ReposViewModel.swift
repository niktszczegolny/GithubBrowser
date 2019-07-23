//
//  ReposViewModel.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

protocol ReposListViewModeling: TopViewModeling, ViewControllerModeling, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    var onReloadData: (() -> Void)? { get set }
    var onSelectRepository: ((Repository) -> Void)? { get set }
    var onLoadingStateChange: ((Bool) -> Void)? { get set }
    var onEmptyStateChange: ((Bool) -> Void)? { get set }

    func getRepos(_ query: String?)
}

class ReposListViewModel: NSObject, ReposListViewModeling {

    var title: String { return "ReposListView".localized }
    var onViewModelFinished: (() -> Void)?
    var onReloadData: (() -> Void)?
    var onSelectRepository: ((Repository) -> Void)?
    var onEmptyStateChange: ((Bool) -> Void)? {
        didSet { onEmptyStateChange?(repos == nil || repos?.count == 0) }
    }

    // refresh right after update value
    var onLoadingStateChange: ((Bool) -> Void)? {
        didSet { onLoadingStateChange?(isLoading) }
    }

    // private
    private var repos: [Repository]? {
        didSet { onEmptyStateChange?(repos == nil || repos?.count == 0) }
    }
    private var savedQuery: String?
    private var savedSearchBar: UISearchBar?

    private var isLoading: Bool = false {
        didSet {
            if isLoading != oldValue {
                onLoadingStateChange?(isLoading)
            }
        }
    }

    override init() {
        super.init()
        getRepos(nil)
    }

    func getRepos(_ query: String?) {
        savedSearchBar?.isLoading = true
        isLoading = true

        APIMethod.getRepos(query).perform { [weak self, query] (repos, response, error) in
            self?.onReloadData?()
            self?.repos = repos
            self?.savedSearchBar?.isLoading = false
            self?.isLoading = false
            guard query == self?.savedQuery else { return }
            self?.savedQuery = nil
            self?.savedSearchBar = nil
        }
    }

}

// MARK: Table View Data Source & Delegate

extension ReposListViewModel {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // show 10 loading state cells
        return repos?.count ?? (isLoading ? 10 : 0)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RepoCell = tableView.dequeueReusableCell() else { return UITableViewCell() }
        if let repo = repos?[safe: indexPath.row] {
            cell.viewModel = RepoCellViewModel(repository: repo)
        }
        cell.setLoading(isLoading)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repo = repos?[safe: indexPath.row] else { return }
        onSelectRepository?(repo)
    }

}

// MARK: Search Results Updating

extension ReposListViewModel {

    func updateSearchResults(for searchController: UISearchController) {
        let searchingDelay: TimeInterval = 0.5
        self.savedQuery = searchController.searchBar.text

        // save search bar to show loader
        if searchController.isActive == true {
            self.savedSearchBar = searchController.searchBar
        }

        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: searchingDelay)
    }

    @objc private func reload() {
        getRepos(savedQuery)
    }

}
