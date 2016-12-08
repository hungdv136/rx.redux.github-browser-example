//
//  ItemSection.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import RxDataSources

protocol IdentifiableModelType: IdentifiableType, Equatable { }

struct ItemSection<T: IdentifiableModelType> {
    let header: String
    var items: [T]
}

extension ItemSection: SectionModelType {
    typealias Item = T
    typealias Identity = String
    
    init(original: ItemSection, items: [Item]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return header
    }
}
