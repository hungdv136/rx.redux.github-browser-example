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
    func fetchGitHubRepositories(_ completion: ((Error?) -> Void)? = nil) -> (@escaping GetState, @escaping DispatchFunction) -> Void {
        return { getState, dispatch in
            guard let state = getState() as? AppState, let authState = state.authenticationState  else { return }
            guard case let LoggedInState.loggedIn(configuration) = authState.loggedInState  else { return }
            
            _ = dispatch(RepositoryAction.startFetching)
            
            _ = Octokit(configuration).repositories(owner: "gaearon") { response in
                DispatchQueue.main.async {
                    _ = dispatch(RepositoryAction.endFetching)
                }
                
                switch response {
                case .failure(let error):
                    completion?(error)
                    
                case .success(let repositories):
                    DispatchQueue.main.async {
                        _ = dispatch(RepositoryAction.setRepostories(repositories: repositories))
                    }
                    completion?(nil)
                }
            }
        }
    }
}
