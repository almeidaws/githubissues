//
//  AuthStateError.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

enum AuthStateError: Error, LocalizedError, CustomStringConvertible, CustomDebugStringConvertible, Hashable {
    case firebase(Error)
    case login(LoginError)
    
    var description: String {
        switch self {
        case .firebase(let error):
            return "An error with Firebase happened: \(error)."
        case .login(let error):
            return "An error related to login did happen: \(error)"
            
        }
    }
    
    var errorDescription: String? {
        return self.description
    }
        
    var debugDescription: String {
        return self.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.description)
    }
    
    static func == (lhs: AuthStateError, rhs: AuthStateError) -> Bool {
        return lhs.description == rhs.description
    }
}
