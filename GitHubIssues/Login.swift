//
//  Login.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

protocol Login {
    var delegate: LoginDelegate? { get set }
    func login()
    func logout()
}
