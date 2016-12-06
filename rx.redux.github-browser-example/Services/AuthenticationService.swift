//
//  AuthenticationService.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import Foundation
import Octokit
import SAMKeychain

final class AuthenticationService {
    
    func authenticationData() -> TokenConfiguration? {
        if let data = SAMKeychain.passwordData(forService: "GitHubAuth", account: "TokenConfiguration") {
            return TokenConfiguration(data: data)
        }
        return nil
    }
    
    func saveAuthenticationData(_ token: TokenConfiguration) {
        SAMKeychain.setPasswordData(token.toData(), forService: "GitHubAuth", account: "TokenConfiguration")
    }
}

