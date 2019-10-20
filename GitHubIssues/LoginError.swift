//
//  LoginModelError.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Firebase

enum LoginError: Error, LocalizedError, CustomStringConvertible, CustomDebugStringConvertible, Hashable {
    
    case firebase(Error)
    case withoutCredential
    case withoutAuthDataResult
    case withoutName
    case withoutEmail
    case userCancelledLogin
    
    var description: String {
        switch self {
        case .firebase(let error):
            return "An error with Firebase happened: \(error)."
        case .withoutCredential:
            return "There's no credential to perform login. That should be an impossible situation."
        case .withoutAuthDataResult:
            return "There's no AuthDataResult to continue the login flow."
        case .withoutName:
            return "The user hasn't a name."
        case .withoutEmail:
            return "The user hans't an e-mail."
        case .userCancelledLogin:
            return "The user has cancelled the login flow."
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
    
    static func == (lhs: LoginError, rhs: LoginError) -> Bool {
        return lhs.description == rhs.description
    }
}
