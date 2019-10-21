//
//  AuthStateMock.swift
//  GitHubIssuesTests
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
@testable import GitHub_Issues

class AuthStateMock: AuthState {
    
    var delegate: AuthStateDelegate?
    var user: User?
    var error: AuthStateError?
    
    func startObserving() {
        if let error = self.error {
            self.delegate?.authState(self, didChange: .failure(error))
        } else {
            self.delegate?.authState(self, didChange: .success(self.user))
        }
    }
    
    func stopObserving() {
        if let error = self.error {
            self.delegate?.authState(self, didChange: .failure(error))
        }
    }
}
