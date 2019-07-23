//
//  ReposListViewController.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class ReposListViewController: UITableViewController {

    // public properties
    var viewModel: ReposListViewModeling? {
        didSet { fillWithData() }
    }

    // private properties
    private let searchController = UISearchController(searchResultsController: nil)
    private let emptyView = EmptyView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fillWithData()
    }

}

// MARK: Private methods

extension ReposListViewController {

    private func setupUI() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchResultsUpdater = viewModel
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Repos Search Bar Placeholder".localized

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(performRefreshAction), for: .valueChanged)

        tableView.register(RepoCell.self)
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.estimatedRowHeight = 60.0
        tableView.separatorStyle = .none
    }

    private func fillWithData() {
        title = viewModel?.title
        viewModel?.onReloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        }
        viewModel?.onLoadingStateChange = { [weak self] loadingState in
            DispatchQueue.main.async { self?.tableView.reloadData() }
        }
        viewModel?.onEmptyStateChange = { [weak self] empty in
            DispatchQueue.main.async { self?.tableView?.backgroundView = empty ? self?.emptyView : nil }
        }
    }

    @IBAction private func performRefreshAction() {
        viewModel?.getRepos(searchController.searchBar.text)
    }

}
