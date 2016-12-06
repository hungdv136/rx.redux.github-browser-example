//
//  Repository.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import Octokit
import RxDataSources

extension Repository: IdentifiableModelType {
    public var identity: String {
        return "\(id)"
    }
}
