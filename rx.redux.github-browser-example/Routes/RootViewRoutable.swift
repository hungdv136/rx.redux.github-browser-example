//
//  Routes.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import RxRedux
import RxReduxRouter

let loginRoute = "loginRoute"
let oAuthRoute = "oAuthRoute"
let mainViewRoute = "mainViewRoute"
let bookmarkRoute = "bookmarkRoute"
let repositoryDetailRoute = "repositoryDetailRoute"


final class RootRoutable: Routable {
    init(window: UIWindow) {
        self.window = window
    }
    
    func changeRouteSegment(_ from: String, to: String, animated: Bool, completion: @escaping RoutingCompletionHandler) -> Routable {
        if to == loginRoute {
            return setToLoginViewController(completion:  completion)
        }
        else if to == mainViewRoute {
            return setToMainViewController(completion:  completion)
        }
        fatalError("Route not supported!")
    }
    
    func pushRouteSegment(_ routeElementId: String, animated: Bool, completion: @escaping RoutingCompletionHandler) -> Routable {
        if routeElementId == loginRoute {
            return setToLoginViewController(completion:  completion)
        }
        else if routeElementId == mainViewRoute {
            return setToMainViewController(completion:  completion)
        }
        
        fatalError("Route not supported!")
    }

    func popRouteSegment(_ routeElementId: String, animated: Bool, completion: @escaping RoutingCompletionHandler) {
        completion()
    }

    private func setToLoginViewController(completion: @escaping RoutingCompletionHandler) -> Routable {
        window.rootViewController = LoginViewController()
        completion()
        return LoginViewRoutable(window.rootViewController!)
    }
    
    private func setToMainViewController(completion: @escaping RoutingCompletionHandler) -> Routable {
        window.rootViewController = UINavigationController(rootViewController: MainViewController())
        completion()
        return MainViewRoutable(window.rootViewController!)
    }
    
    private let window: UIWindow
}


class RepositoryDetailRoutable: Routable {}
class BookmarkRoutable: Routable {}
class OAuthRoutable: Routable {}
