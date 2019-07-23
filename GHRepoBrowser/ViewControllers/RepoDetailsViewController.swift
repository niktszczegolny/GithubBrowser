//
//  RepoDetailsViewController.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UITableViewController {

    // public properties
    var viewModel: RepoDetailsViewModeling? {
        didSet { fillWithData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fillWithData()
    }

}
// MARK: Private methods

extension RepoDetailsViewController {

    private func setupUI() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(performRefreshAction), for: .valueChanged)

        tableView = UITableView(frame: tableView.frame, style: .grouped)
        tableView.register(OwnerCell.self)
        tableView.register(RepoDetailsCell.self)
        tableView.register(ReadmeCell.self)
        tableView.register(DetailsCell.self)
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.estimatedRowHeight = 60.0
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
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
    }

    @IBAction private func performRefreshAction() {
        viewModel?.getRepoDetails()
    }

}
