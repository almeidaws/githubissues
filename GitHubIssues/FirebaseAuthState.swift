//
//  AuthState.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAuthState: AuthState {
    
    private let provider = OAuthProvider(providerID: "github.com")
    private var handle: AuthStateDidChangeListenerHandle?
    weak var delegate: AuthStateDelegate?
    
    func startObserving() {
        self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.handleStateChanging(user)
        }
    }
    
    func stopObserving() {
        guard let handle = self.handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
        self.handle = nil
    }
    
    private func handleStateChanging(_ user: FirebaseAuth.User?) {
        if let user = user {
            let id = user.uid
            guard let name = user.displayName else {
                self.delegate?.authState(self, didChange: .failure(.login(.withoutName)))
                return
            }
            
            guard let email = user.email else {
                self.delegate?.authState(self, didChange: .failure(.login(.withoutEmail)))
                return
            }
            
            let user = User(id: id, name: name, email: email)
            self.delegate?.authState(self, didChange: .success(user))
        } else {
            self.delegate?.authState(self, didChange: .success(nil))
        }
    }
}
