//
//  Codable.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh Van on 12/8/16.
//  Copyright © 2016 ChuCuoi. All rights reserved.
//

import Foundation

protocol Codable {
    init?(coder: NSCoder)
    func encode(with coder: NSCoder)
}

final class CoderHelper<T: Codable>: NSObject, NSCoding {
    init(object: T) {
        self.object = object
        super.init()
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        super.init()
        object = T(coder: aDecoder)
    }
    
    @objc func encode(with coder: NSCoder) {
        if let object = object {
            object.encode(with: coder)
        }
    }
    
    private(set) var object: T?
}
