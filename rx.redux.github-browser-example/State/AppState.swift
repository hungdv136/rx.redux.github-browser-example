//
//  State.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import RxRedux
import RxReduxRouter
import Octokit

struct AppState: StateType, HasNavigationState {
    
    // MARK: Data State
    
    var authenticationState: AuthenticationState? = nil
    var navigationState = NavigationState()
    var repositories = [Repository]()
    
    
    // MARK: UI State
    
    var isFectchingRepositories = false
}

