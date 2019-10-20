//
//  IssueCreator.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

struct IssueCreator: Codable, Hashable, CustomDebugStringConvertible {
    let id: Int
    let login: String
    let avatarUrl: URL
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    var debugDescription: String {
        return "Creator '\(self.id)' with name '\(self.login)'"
    }
}
