//
//  BookmarkActions.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import Foundation
import RxRedux
import RxReduxRouter

enum BookmarkActions: Action {
    case createBookmark(route: [String], routeSpecificData: Any?)
}
