//
//  State.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import RxRedux
import RxReduxRouter

struct AppState: StateType, HasNavigationState {
    
    // MARK: Data State
    
    var authenticationState: AuthenticationState? = nil
    var navigationState = NavigationState()
    var repositories = [GitHubRepository]()
    
    
    // MARK: UI State
    
    var isFectchingRepositories = false
}

extension AppState: Codable {
    init?(coder: NSCoder) {
        if let helpers = coder.decodeObject(forKey: "repositories") as? [CoderHelper<GitHubRepository>] {
            repositories = helpers.flatMap { $0.object }
        }
    }
    
    public func encode(with coder: NSCoder) {
        let helpers = repositories.map { CoderHelper(object: $0) }
        coder.encode(helpers, forKey: "repositories")
    }
}
