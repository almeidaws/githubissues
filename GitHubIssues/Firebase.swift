//
//  Firebase.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Firebase

struct Firebase {
    private init() { }
    
    static func initialize() {
        FirebaseApp.configure()
    }
}
