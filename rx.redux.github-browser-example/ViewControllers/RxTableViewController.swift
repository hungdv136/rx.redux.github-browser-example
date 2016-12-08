//
//  RxTableViewController.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh Van on 12/7/16.
//  Copyright © 2016 ChuCuoi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxTableViewController: UITableViewController, LoadingIndicatorView {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        tableView.dataSource = nil
    }
    
    private func setupSearchBar() {
        tableView.tableHeaderView = searchBar
        searchBar.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 64)
    }
    
    let disposeBag = DisposeBag()
    let searchBar = UISearchBar()
}
