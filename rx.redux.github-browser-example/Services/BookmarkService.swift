//
//  BookmarkService.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import Foundation
import RxRedux
import RxReduxRouter
import Octokit

final class BookmarkService {

    static func isRepositoryBookmarked(state: AppState, currentRepository: Repository) -> Bool {
        let bookmarkActive = !state.bookmarks.contains { route, data in
            guard let repository = data as? Repository else { return false }

            return RouteHash(route: route) == RouteHash(route: [mainViewRoute, repositoryDetailRoute]) &&
                repository.name == currentRepository.name
        }
        
        return bookmarkActive
    }
    
}
