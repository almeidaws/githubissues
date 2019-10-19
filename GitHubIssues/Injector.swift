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
        self.injectIssuesViewController(at: container)
    }
    
    static func initialViewController(from container: Container) -> UIViewController {
        guard let initial = container.resolve(LoginViewController.self) else { fatalError("There's no dependency for initial view controller") }
        return initial
    }
    
    private static func injectIssuesViewController(at container: Container) {
        Injector.inject(IssuesViewController.self, fromStoryboardNamed: "Issues", at: container)
    }
    
    private static func injectLoginViewController(at container: Container) {
        Injector.inject(LoginViewController.self, fromStoryboardNamed: "Login", at: container) { controller in
            controller.login = container.resolve(Login.self)
        }
    }
    
    private static func inject<Controller: UIViewController>(_ controller: Controller.Type, fromStoryboardNamed storyboard: String, at container: Container, beforeRegistering: ((Controller) -> Void)? = nil) {
        container.register(controller.self) { resolver in
            let storyboard = UIStoryboard(name: storyboard, bundle: nil)
            guard let initial = storyboard.instantiateInitialViewController() else {
                fatalError(K.Error.Message.withoutInitialController)
            }
            guard let concreteController = initial as? Controller else {
                fatalError(K.Error.Message.initialViewControllerMustBeOfType(LoginViewController.self))
            }
            
            concreteController.modalPresentationStyle = .fullScreen
            beforeRegistering?(concreteController)
            return concreteController
        }

    }
    
    private static func injectLogin(at container: Container) {
        container.register(Login.self) { _ in GitHubLogin() }
    }
}
