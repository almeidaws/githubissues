//
//  GitHubAPIError.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

enum MoyaProviderError: Error, LocalizedError, CustomStringConvertible, CustomDebugStringConvertible {
    case unexpectedStatusCode(Int)
    
    var description: String {
        switch self {
        case .unexpectedStatusCode(let statusCode):
            return "The API has returned an unexpected status code: \(statusCode)"
        }
    }
    
    var errorDescription: String? {
        return self.description
    }
        
    var debugDescription: String {
        return self.description
    }
}
