//
//  Issue.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

struct Issue: Codable, Hashable, CustomDebugStringConvertible {
    let id: Int
    let htmlUrl: URL
    let number: Int
    let title: String
    let state: IssueState
    let body: String
    let createdAt: Date
    let user: IssueCreator
    let pullRequest: PullRequest?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    var debugDescription: String {
        return "Issue #\(self.number) '\(self.title)'"
    }
}
