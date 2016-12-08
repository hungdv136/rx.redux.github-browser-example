//
//  RepositoriesViewController.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import UIKit
import RxRedux
import RxReduxRouter
import RxSwift
import RxCocoa
import RxDataSources

final class RepositoriesViewController: RxTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("GitHub", comment: "")
        refreshRepositories()
        setupTableView()
        setupRefreshControl()
        setupDataBinding()
    }
    
    private func setupTableView() {
        tableView.registerCell(RepositoryTableViewCell.self)
        
        dataSource.configureCell = { _, tv, ip, model in
            let cell: RepositoryTableViewCell = tv.dequeueReusableCell(forIndexPath: ip)
            cell.model = model
            return cell
        }
        
        tableView.rx.modelSelected(GitHubRepository.self).subscribe(onNext: { repository in
            let newRoute = [mainViewRoute, repositoryDetailRoute]
            store.dispatch(NavigationActions.setRouteSpecificData(route: newRoute, data: repository))
            store.dispatch(NavigationActions.setRouteAction(route: newRoute, animated: true))
        }).addDisposableTo(disposeBag)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.rx.controlEvent(.valueChanged).subscribe(onNext: { [weak self] in
            self?.refreshRepositories()
        }).addDisposableTo(disposeBag)
    }
    
    private func setupDataBinding() {
        store.state.map { $0.isFectchingRepositories }.distinctUntilChanged().drive(onNext: { [weak self] isFetching in
            self?.updateLoadingActivity(showActivity: isFetching)
        }).addDisposableTo(disposeBag)
        
        Driver.combineLatest(searchBar.rx.text.asDriver(), store.state.map{ $0.repositories }) { (text, repositories) -> [GitHubRepository] in
            guard let text = text, !text.isEmpty else { return repositories}
            return repositories.filter { $0.name?.localizedCaseInsensitiveContains(text) ?? false }
        }.map { [ItemSection<GitHubRepository>(header: "" , items: $0)] }
        .drive(tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
    }
    
    private func refreshRepositories() {
        store.dispatch(repositoryActionCreator.fetchGitHubRepositories() { error in
            self.refreshControl?.endRefreshing()
            guard let error = error else { return }
            print("Can not load repositories \(error)")
        })
    }

    // MARK: Properties
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ItemSection<GitHubRepository>>()
    private lazy var repositoryActionCreator = RepositoryActionCreator()
}
