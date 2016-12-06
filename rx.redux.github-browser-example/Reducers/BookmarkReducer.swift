//
//  BookmarksReducer.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import Foundation
import RxRedux
import RxReduxRouter

struct BookmarkReducer: Reducer {
    func handleAction(state: AppState, action: Action) -> AppState {
        guard let action = action as? BookmarkActions  else { return state }
        
        switch action {
        case .createBookmark(let route, let routeSpecificData):
            var state = state
            let bookmark = (route: route, routeSpecificData: routeSpecificData)
            state.bookmarks.append(bookmark)
            return state
        }
    }
}

