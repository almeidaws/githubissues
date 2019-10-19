//
//  LoginViewController.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: RoundedLoginButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var login: Login?
    private lazy var authState = AuthState();
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupDelegates()
        self.showActivityIndicator()
        self.authState.startObserving()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.authState.stopObserving()
    }
    
    private func setupDelegates() {
        self.authState.delegate = self
        self.login?.delegate = self
    }
    
    private func showActivityIndicator() {
        self.loginButton.hide { self.activityIndicator.startAnimating() }
    }
    
    private func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.loginButton.show()
    }
    
    @IBAction func handleLogin(_ sender: UIButton) {
        self.showActivityIndicator()
        self.login?.login()
    }
}

extension LoginViewController: AuthStateDelegate {
    func authState(_ authState: AuthState, didChange result: Result<User?, AuthStateError>) {
        self.hideActivityIndicator()
        
        switch result {
        case .success(let user) where user != nil:
            print("Já logado")
        case .failure(let error):
            self.alert(error)
        case .success:
            break
        }
    }
}

extension LoginViewController: LoginDelegate {
    func login(_ login: Login, didLogin result: Result<User, LoginModelError>) {
        self.hideActivityIndicator()
        
        switch result {
        case .success(let user):
            print(user)
        case .failure(let error):
            if case .userCancelledLogin = error { return }
            self.alert(error)
        }
    }
}
