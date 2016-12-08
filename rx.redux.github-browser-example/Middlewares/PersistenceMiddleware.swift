//
//  PersistenceMiddleware.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh Van on 12/7/16.
//  Copyright © 2016 ChuCuoi. All rights reserved.
//

import RxRedux
import CoreData
import Foundation

struct PersistenceMiddleware: Middleware {
    init(database: Database) {
        self.database = database
    }
    
    public func process(getState: @escaping GetState, dispatch: @escaping DispatchFunction) -> (@escaping DispatchFunction) -> DispatchFunction {
        return { next in
            return { action in
                let result = next(action)
                guard let state = getState() as? AppState else { return result }
                
                if case RepositoryAction.setRepostories(_) = action {
                    self.saveState(state)
                    return result
                }
                
                if case LaunchActions.initialize = action {
                    self.readState(getState: getState, dispatch: dispatch)
                }
                
                return result
            }
        }
    }
    
    private func saveState(_ state: AppState) {
       let object = NSKeyedArchiver.archivedData(withRootObject: CoderHelper(object: state))
        database.connection.asyncReadWrite({ tx in
            tx.setObject(object, forKey: "AppState", inCollection: "AppStateCollection")
        })
    }
    
    private func readState(getState: @escaping GetState, dispatch: @escaping DispatchFunction) {
        database.connection.asyncRead({ tx in
            guard let data = tx.object(forKey: "AppState", inCollection: "AppStateCollection") as? Data else { return }
            let appState = NSKeyedUnarchiver.unarchiveObject(with: data) as? CoderHelper<AppState>
            _ = dispatch(RepositoryAction.setRepostories(repositories: appState?.object?.repositories ?? []))
        })
    }
    
    var database: Database
}
