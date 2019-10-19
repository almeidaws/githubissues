//
//  LoginModelDelegate.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

protocol LoginDelegate: AnyObject {
    func login(_ login: Login, didLogin result: Result<User, LoginModelError>)
}
