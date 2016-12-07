//
//  AppDelegate.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import UIKit
import RxRedux
import RxReduxRouter

private let reducer = CombinedReducer(reducers: NavigationReducer<AppState>(), AuthenticationReducer(), RepositoryReducer())
let store = Store<AppState>(state: AppState(), reducer: reducer, middlewares: [ThunkMiddleware()])

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router<AppState>!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()

        let rootRoutable = RootRoutable(window: window!)
        router = Router(store: store, rootRoutable: rootRoutable) { state in
            return state.navigationState
        }
        
        store.dispatch(AuthenticationAction.initializeGitHubConfigurations)
        
        if let authState = store.getState().authenticationState, case .loggedIn(_) = authState.loggedInState {
            store.dispatch(NavigationActions.setRouteAction(route: [mainViewRoute], animated: true))
        }
        else {
            store.dispatch(NavigationActions.setRouteAction(route: [loginRoute], animated: true))
        }

        window?.makeKeyAndVisible()

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        store.dispatch(AuthenticateActionCreator().handleOpenURL(url: url))
        return false
    }

}
