//
//  TableViewExtensions.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_: T.Type) where T: ReusableViewType {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerCell<T: UITableViewCell>(_: T.Type) where T: ReusableViewType, T: NibLoadableViewType {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableViewType {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}


protocol ReusableViewType: class {
    static var reuseIdentifier: String { get }
}

protocol NibLoadableViewType: class {
    static var nibName: String { get }
}

extension ReusableViewType where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewType { }

extension UICollectionReusableView: ReusableViewType { }
