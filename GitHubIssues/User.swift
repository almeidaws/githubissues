//
//  User.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

struct User: Codable, Hashable, CustomDebugStringConvertible {
    let id: String
    let name: String
    let email: String
    
    var debugDescription: String {
        return "User '\(self.id)' with name '\(self.name)' and e-mail '\(self.email)'"
    }
}
