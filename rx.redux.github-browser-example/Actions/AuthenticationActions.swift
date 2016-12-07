//
//  AuthenticationActions.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import RxRedux
import RxReduxRouter
import Octokit

struct AuthenticateActionCreator {
    func authenticateUser() -> (@escaping GetState, @escaping DispatchFunction) -> Void {
        return { getState, dispatch in
            guard let state = getState() as? AppState, let config = state.authenticationState?.oAuthConfig else { return }
            
            let url = config.authenticate()
            
            if let url = url {
                _ = dispatch(AuthenticationAction.setOAuthURL(oAuthUrl: url))
                _ = dispatch(NavigationActions.setRouteAction(route: [loginRoute, oAuthRoute], animated: true))
            }
        }
    }
    
    func handleOpenURL(url: URL) -> (@escaping GetState, @escaping DispatchFunction) -> Void {
        return { getState, dispatch in
            guard let state = getState() as? AppState else { return }
            
            state.authenticationState?.oAuthConfig?.handleOpenURL(url: url) { (config: TokenConfiguration) in
                AuthenticationService().saveAuthenticationData(config)
                _ = dispatch(AuthenticationAction.updateLoggedInState(loggedInState: .loggedIn(config)))
                _ = dispatch(NavigationActions.setRouteAction(route: [mainViewRoute], animated: true))
            }
        }
    }
}

enum AuthenticationAction: Action {
    case setOAuthURL(oAuthUrl: URL)
    case updateLoggedInState(loggedInState: LoggedInState)
    case initializeGitHubConfigurations
}

