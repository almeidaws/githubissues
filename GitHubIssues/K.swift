//
//  K.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

struct K {
    private init() { }
    
    struct Error {
        private init() { }
        
        struct Code {
            private init() { }
            static let useCancelledLogin = 17058
        }
        
        struct Message {
            private init() { }
            
            static let withoutInitialController = "There's no initial view controller"
            static func initialViewControllerMustBeOfType(_ type: Any) -> String {
                return "The initial controller must be of type \(String(describing: Any.self))"
            }
        }
    }
}
