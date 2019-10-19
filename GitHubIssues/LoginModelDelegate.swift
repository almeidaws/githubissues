//
//  LoginModelDelegate.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

protocol LoginModelDelegate: AnyObject {
    func loginModel(_ loginModel: LoginModel, didLogin result: Result<GitHubUser, LoginModelError>)
}
