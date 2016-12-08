//
//  GitHubRepository.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import RxDataSources

struct GitHubRepository {
    let id: Int
    var name: String?
    var htmlURL: String?
}

extension GitHubRepository: IdentifiableModelType {
    public var identity: String {
        return "\(id)"
    }
}

func ==(lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
    return lhs.id == lhs.id
}

// MARK: Persistence

extension GitHubRepository: Codable {
    init?(coder: NSCoder) {
        id          = coder.decodeInteger(forKey: "id")
        name        = coder.decodeObject(forKey: "name") as? String
        htmlURL     = coder.decodeObject(forKey: "htmlURL") as? String
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(htmlURL, forKey: "htmlURL")
    }
}
