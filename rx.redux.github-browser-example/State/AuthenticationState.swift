//
//  AuthenticationState.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import Octokit

struct AuthenticationState {
    var oAuthConfig: OAuthConfiguration?
    var oAuthURL: URL?
    var loggedInState: LoggedInState
}

enum LoggedInState {
    case notLoggedIn
    case loggedIn(TokenConfiguration)
}
