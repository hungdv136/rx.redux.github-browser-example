//
//  RepositoriesViewRoutable.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import RxRedux
import RxReduxRouter

final class RepositoriesViewRoutable: Routable {
    
    let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pushRouteSegment(_ routeElementId: String, animated: Bool, completion: @escaping RoutingCompletionHandler) -> Routable {
        guard let navController = (viewController as? UINavigationController) else {
            fatalError("The root controller should be UINavigationController")
        }
        
        if routeElementId == repositoryDetailRoute {
            navController.pushViewController(RepositoryDetailViewController(), animated: true, completion: completion)
            return RepositoryDetailRoutable()
        }
        
        fatalError("Cannot handle this route change!")
    }
    
    func popRouteSegment(_ routeElementId: String, animated: Bool, completion: @escaping RoutingCompletionHandler) {
        completion()
    }
}
