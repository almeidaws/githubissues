//
//  GitHubLogin.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Firebase

class GitHubLogin: Login {
    
    private let provider = OAuthProvider(providerID: "github.com")
    weak var delegate: LoginDelegate?
    
    func login() {
        provider.scopes = ["user:email"]
        provider.getCredentialWith(nil) { credential, error in
            if let error = error {
                if error._code == K.Error.Code.useCancelledLogin {
                    self.delegate?.login(self, didLogin: .failure(.userCancelledLogin))
                } else {
                    self.delegate?.login(self, didLogin: .failure(.firebase(error)))
                }
                return
            }
            
            guard let credential = credential else {
                self.delegate?.login(self, didLogin: .failure(.withoutCredential))
                return
            }
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.delegate?.login(self, didLogin: .failure(.firebase(error)))
                    return
                }
                
                guard let authResult = authResult else {
                    self.delegate?.login(self, didLogin: .failure(.withoutAuthDataResult))
                    return
                }
                
                
                let id = authResult.user.uid
                guard let name = authResult.user.displayName else {
                    self.delegate?.login(self, didLogin: .failure(.withoutName))
                    return
                }
                
                guard let email = authResult.user.email else {
                    self.delegate?.login(self, didLogin: .failure(.withoutEmail))
                    return
                }
                
                let user = User(id: id, name: name, email: email)
                self.delegate?.login(self, didLogin: .success(user))
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.delegate?.login(self, didLogout: .success(()))
        } catch {
            self.delegate?.login(self, didLogout: .failure(.firebase(error)))
        }
    }
}
