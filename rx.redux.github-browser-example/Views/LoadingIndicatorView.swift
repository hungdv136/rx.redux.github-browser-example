//
//  Loading.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh Van on 12/6/16.
//  Copyright © 2016 ChuCuoi. All rights reserved.
//

import UIKit

protocol LoadingIndicatorView {
    var loadingActivityBackgroundColor: UIColor? { get }
}

extension LoadingIndicatorView {
    var loadingActivityBackgroundColor: UIColor? {
        return nil
    }
}

extension LoadingIndicatorView where Self: UIViewController {
    func addLoadingActivity(inTableView tableView: UITableView) {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        footerView.backgroundColor = loadingActivityBackgroundColor
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        footerView.addSubview(spinner)
        spinner.autoCenterInSuperview()
        tableView.tableFooterView = footerView
        spinner.startAnimating()
    }
    
    func removeLoadingActivity(fromTableView tableView: UITableView) {
       tableView.tableFooterView = nil
    }
    
    func updateLoadingActivity(inTableView tableView: UITableView, showActivity: Bool) {
        if showActivity {
            addLoadingActivity(inTableView: tableView)
        }
        else {
            removeLoadingActivity(fromTableView: tableView)
        }
    }
}

extension LoadingIndicatorView where Self: UITableViewController {
    func addLoadingActivity() {
        addLoadingActivity(inTableView: tableView)
    }
    
    func removeLoadingActivity() {
        removeLoadingActivity(fromTableView: tableView)
    }
    
    func updateLoadingActivity(showActivity: Bool) {
        updateLoadingActivity(inTableView: tableView, showActivity: showActivity)
    }
}
