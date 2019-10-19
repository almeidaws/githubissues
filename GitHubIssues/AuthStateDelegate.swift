//
//  AuthStateDelegate.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

protocol AuthStateDelegate: AnyObject {
    
    func authState(_ authState: AuthState, didChange result: Result<GitHubUser?, AuthStateError>)
}
