//
//  GitHubAPIReducers.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import RxRedux
import RxReduxRouter
import Octokit

struct RepositoryReducer: Reducer
{
    func handleAction(state: AppState, action: Action) -> AppState {
        guard let action = action as? RepositoryAction  else { return state }
        
        var state = state
        
        switch action {
        case .setRepostories(let repositories):
            state.repositories = repositories
            
        case .startFetching:
            state.isFectchingRepositories = true
            
        case .endFetching:
            state.isFectchingRepositories = false
        }
        
        return state
    }
}

