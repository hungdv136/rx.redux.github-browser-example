//
//  BookmarkTableViewCell.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import Foundation
import UIKit
import Octokit

class BookmarkTableViewCell: UITableViewCell {
    var model: Bookmark? {
        didSet {
            if let repository = model?.routeSpecificData as? Repository {
                self.textLabel!.text = repository.name ?? ""
            }
        }
    }
}
