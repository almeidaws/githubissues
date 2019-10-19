//
//  LoginModel.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Firebase

class LoginModel {
    
    private let provider = OAuthProvider(providerID: "github.com")
    weak var delegate: LoginModelDelegate?
    
    func login() {
        provider.scopes = ["user:email"]
        provider.getCredentialWith(nil) { credential, error in
            if let error = error {
                if error._code == K.Error.Code.useCancelledLogin {
                    self.delegate?.loginModel(self, didLogin: .failure(.userCancelledLogin))
                } else {
                    self.delegate?.loginModel(self, didLogin: .failure(.firebase(error)))
                }
                return
            }
            
            guard let credential = credential else {
                self.delegate?.loginModel(self, didLogin: .failure(.withoutCredential))
                return
            }
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.delegate?.loginModel(self, didLogin: .failure(.firebase(error)))
                    return
                }
                
                guard let authResult = authResult else {
                    self.delegate?.loginModel(self, didLogin: .failure(.withoutAuthDataResult))
                    return
                }
                
                
                let id = authResult.user.uid
                guard let name = authResult.user.displayName else {
                    self.delegate?.loginModel(self, didLogin: .failure(.withoutName))
                    return
                }
                
                guard let email = authResult.user.email else {
                    self.delegate?.loginModel(self, didLogin: .failure(.withoutEmail))
                    return
                }
                
                let user = GitHubUser(id: id, name: name, email: email)
                self.delegate?.loginModel(self, didLogin: .success(user))
            }
        }
    }
}
