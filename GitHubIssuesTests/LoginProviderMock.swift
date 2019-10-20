//
//  LoginProviderMock.swift
//  GitHubIssuesTests
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

@testable import GitHub_Issues

class LoginProviderMock: Login {
    
    var delegate: LoginDelegate?
    var user: User?
    var error: LoginError?
    
    func login() {
        if let error = self.error {
            self.delegate?.login(self, didLogin: .failure(error))
        } else if let user = self.user {
            self.delegate?.login(self, didLogin: .success(user))
        }
    }
    
    func logout() {
        if let error = self.error {
            self.delegate?.login(self, didLogout: .failure(error))
        } else {
            self.delegate?.login(self, didLogout: .success(()))
        }
    }
}
