//
//  GitHubRepositoriesActions.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import Foundation
import RxRedux
import RxReduxRouter
import Octokit

enum RepositoryAction: Action {
    case setRepostories(repositories: [Repository])
    case startFetching
    case endFetching
}

struct RepositoryActionCreator {
    func fetchGitHubRepositories(_ completion: ((Error?) -> Void)? = nil) -> (GetState, DispatchFunction) -> Void {
        return { getState, dispatch in
            guard let state = getState() as? AppState, let authState = state.authenticationState  else { return }
            guard case let LoggedInState.loggedIn(configuration) = authState.loggedInState  else { return }
            
             _ = store.dispatch(RepositoryAction.startFetching)
            
            _ = Octokit(configuration).repositories { response in
                DispatchQueue.main.async {
                    _ = store.dispatch(RepositoryAction.endFetching)
                }
                
                switch response {
                case .failure(let error):
                    completion?(error)
                    
                case .success(let repositories):
                    DispatchQueue.main.async {
                        _ = store.dispatch(RepositoryAction.setRepostories(repositories: repositories))
                    }
                    completion?(nil)
                }
            }
        }
    }
}
