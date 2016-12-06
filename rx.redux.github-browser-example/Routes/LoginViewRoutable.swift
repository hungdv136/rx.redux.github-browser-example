//
//  LoginViewRoutable.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import RxRedux
import RxReduxRouter
import SafariServices

final class LoginViewRoutable: Routable {
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pushRouteSegment(_ routeElementId: String, animated: Bool, completion: @escaping RoutingCompletionHandler) -> Routable {
        guard routeElementId == oAuthRoute, let url = store.getState().authenticationState?.oAuthURL else {
            fatalError("Router could not proceed.")
        }
        
        let safariViewController = SFSafariViewController(url: url)
        viewController.present(safariViewController, animated: true, completion: completion)
        return OAuthRoutable()
    }
    
    func popRouteSegment(_ routeElementId: String, animated: Bool, completion: @escaping RoutingCompletionHandler) {
        if routeElementId == oAuthRoute {
            viewController.dismiss(animated: true, completion: completion)
        }
    }
    
    private let viewController: UIViewController
    
}
