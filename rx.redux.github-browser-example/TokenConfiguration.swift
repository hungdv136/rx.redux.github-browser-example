//
//  a.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh Van on 12/6/16.
//  Copyright © 2016 ChuCuoi. All rights reserved.
//

import Octokit

extension TokenConfiguration {
    
    init(data: Data) {
        let json: [String: AnyObject] = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : AnyObject]
        
        self.apiEndpoint = json["endpoint"] as! String
        self.accessToken = { if case let s = json["accesstoken"] as? String , s != "null" { return s } else { return nil } }()
        self.errorDomain = "OktoKitTokenConfiguration"
    }
    
    func toData() -> Data {
        let json: NSDictionary = [
            "endpoint": self.apiEndpoint,
            "accesstoken": self.accessToken ?? "null"
        ]
        
        return try! JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions(rawValue: 0))
    }
    
}
