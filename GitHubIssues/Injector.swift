//
//  Injection.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Swinject
import UIKit

struct Injector {
    private init() { }
    
    static func inject(at container: Container) {
        self.injectLogin(at: container)
        self.injectLoginViewController(at: container)
    }
    
    static func initialViewController(from container: Container) -> UIViewController {
        guard let initial = container.resolve(LoginViewController.self) else { fatalError("There's no dependency for initial view controller") }
        return initial
    }
    
    private static func injectLoginViewController(at container: Container) {
        container.register(LoginViewController.self) { resolver in
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            guard let initial = storyboard.instantiateInitialViewController() else { fatalError("There's no initial view controller") }
            guard let login = initial as? LoginViewController else { fatalError("The initial controller must be of type \(String(describing: LoginViewController.self))") }
            login.login = resolver.resolve(Login.self)
            
            return login
        }
    }
    
    private static func injectLogin(at container: Container) {
        container.register(Login.self) { _ in GitHubLogin() }
    }
}
