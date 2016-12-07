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
import Octokit
import RxSwift
import RxCocoa
import RxDataSources

final class RepositoriesViewController: RxTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("GitHub", comment: "")
        setupTableView()
        setupDataBinding()
    }
    
    private func setupTableView() {
        tableView.registerCell(RepositoryTableViewCell.self)
        
        dataSource.configureCell = { _, tv, ip, model in
            let cell: RepositoryTableViewCell = tv.dequeueReusableCell(forIndexPath: ip)
            cell.model = model
            return cell
        }
        
        tableView.rx.modelSelected(Repository.self).subscribe(onNext: { repository in
            let newRoute = [mainViewRoute, repositoryDetailRoute]
            store.dispatch(NavigationActions.setRouteSpecificData(route: newRoute, data: repository))
            store.dispatch(NavigationActions.setRouteAction(route: newRoute, animated: true))
        }).addDisposableTo(disposeBag)
    }
    
    private func setupDataBinding() {
        store.dispatch(repositoryActionCreator.fetchGitHubRepositories() { error in
            guard let error = error else { return }
            print("Can not load repositories \(error)")
        })
        
        store.state.map { $0.isFectchingRepositories }.distinctUntilChanged().drive(onNext: { [weak self] isFetching in
            self?.updateLoadingActivity(showActivity: isFetching)
        }).addDisposableTo(disposeBag)
        
        Driver.combineLatest(searchBar.rx.text.asDriver(), store.state.map{ $0.repositories }) { (text, repositories) -> [Repository] in
            guard let text = text, !text.isEmpty else { return repositories}
            return repositories.filter { $0.name?.localizedCaseInsensitiveContains(text) ?? false }
        }.map { [ItemSection<Repository>(header: "" , items: $0)] }
        .drive(tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
    }

    // MARK: Properties
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ItemSection<Repository>>()
    private lazy var repositoryActionCreator = RepositoryActionCreator()
}
