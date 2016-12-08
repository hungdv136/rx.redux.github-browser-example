//
//  RepositoryDetailViewController.swift
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

final class RepositoryDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupDataBinding()
    }

    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        guard parent == nil else  { return  }
        
        // Required to update the route, when this VC was dismissed through back button from
        // NavigationController, since we can't intercept the back button
        if store.getState().navigationState.route == [mainViewRoute, repositoryDetailRoute] {
            store.dispatch(NavigationActions.setRouteAction(route: [mainViewRoute], animated: true))
        }
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        NSLayoutConstraint.autoCreateAndInstallConstraints {
            webView.autoPinEdgesToSuperviewEdges()
        }
    }
    
    private func setupDataBinding() {
        store.state.map { state -> GitHubRepository? in
            state.navigationState.getRouteSpecificState(state.navigationState.route)
        }.distinctUntilChanged(==).drive(onNext: { [weak self] repository in
            self?.title = repository?.name ?? ""
            if let url = repository?.htmlURL.flatMap({URL.init(string: $0)}) {
                self?.webView.loadRequest(URLRequest(url: url))
            }
        }).addDisposableTo(disposeBag)
    }
    
    private lazy var webView = UIWebView()
    private let disposeBag = DisposeBag()
}
