//
//  AuthenticationReducer.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import Foundation
import RxRedux
import RxReduxRouter
import Octokit

struct AuthenticationReducer: Reducer
{
    func handleAction(state: AppState, action: Action) -> AppState {
        guard let action = action as? AuthenticationAction  else { return state }
        
        var state = state
        
        switch action {
        case .setOAuthURL(let oAuthUrl):
            state.authenticationState?.oAuthURL = oAuthUrl
            
        case .updateLoggedInState(let loggedInState):
            state.authenticationState?.loggedInState = loggedInState
            
        case .initializeGitHubConfigurations:
            state.authenticationState = initialAuthenticationState()
        }
        
        return state
    }
    
    
    private func initialAuthenticationState() -> AuthenticationState {
        let config = OAuthConfiguration(
            token: gitHubToken,
            secret: gitHubSecret,
            scopes: ["repo", "read:org"]
        )
        
        if let authData = AuthenticationService().authenticationData() {
            return AuthenticationState(
                oAuthConfig: config,
                oAuthURL: nil,
                loggedInState: .loggedIn(authData)
            )
        }
        else {
            return AuthenticationState(
                oAuthConfig: config,
                oAuthURL: nil,
                loggedInState: .notLoggedIn
            )
        }
    }
}



