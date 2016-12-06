//
//  RepositoryDetailCell.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import RxRedux
import RxReduxRouter
import Octokit

final class RepositoryTableViewCell: UITableViewCell {
    var model: Repository? {
        didSet {
            self.textLabel!.text = model?.name ?? ""
        }
    }
}
