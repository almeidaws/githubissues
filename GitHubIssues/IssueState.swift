//
//  IssueState.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

enum IssueState: String, Codable, Hashable, CustomDebugStringConvertible {
    case open = "open"
    case closed = "closed"
    case all = "all"
    
    var debugDescription: String {
        switch self {
        case .open: return "Open"
        case .closed: return "Closed"
        case .all: return "All"
        }
    }
}
