//
//  Database.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh Van on 12/8/16.
//  Copyright © 2016 ChuCuoi. All rights reserved.
//

import Foundation
import YapDatabase

final class Database {
    init() {
        db = YapDatabase(path: "rx.redux.github-browser-example-database")
        db.defaultObjectPolicy = .share
        db.defaultMetadataCacheEnabled = false
        
        connection = db.newConnection()
    }
    
    let connection: YapDatabaseConnection
    fileprivate let db: YapDatabase
}
