//
//  RepositoryDetailCell.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import RxRedux
import RxReduxRouter

final class RepositoryTableViewCell: UITableViewCell {
    var model: GitHubRepository? {
        didSet {
            self.textLabel!.text = model?.name ?? ""
        }
    }
}
