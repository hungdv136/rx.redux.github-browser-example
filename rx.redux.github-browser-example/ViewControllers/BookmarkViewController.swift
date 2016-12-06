//
//  BookmarkViewController.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import UIKit
import RxRedux
import RxReduxRouter

class BookmarkViewController: UIViewController {

    @IBOutlet var tableView: UITableView!


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)


        // Required to update the route, when this VC was dismissed through back button from
        // NavigationController, since we can't intercept the back button
        
        if store.getState().navigationState.route == [mainViewRoute, bookmarkRoute] {
            store.dispatch(NavigationActions.setRouteAction(route: [mainViewRoute], animated: true))
        }
    }
}

//MARK: UITableViewDelegate

extension BookmarkViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedBookmark = self.dataSource!.array[indexPath.row]
//        let routeAction = RxReduxRouter.SetRouteAction(selectedBookmark.route)
//        let setDataAction = RxReduxRouter.SetRouteSpecificData(route:
//            selectedBookmark.route,
//            data: selectedBookmark.routeSpecificData)
//
//        store.dispatch(setDataAction)
//        store.dispatch(routeAction)
    }
    
}
