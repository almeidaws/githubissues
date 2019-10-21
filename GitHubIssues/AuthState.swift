//
//  FirebaseAuthState.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

protocol AuthState {
    var delegate: AuthStateDelegate? { get set }
    func startObserving()
    func stopObserving()
}
