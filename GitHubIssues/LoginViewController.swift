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
    private lazy var loginModel = LoginModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupDelegates()
    }
    
    private func setupDelegates() {
        self.loginModel.delegate = self
    }
    
    @IBAction func handleLogin(_ sender: UIButton) {
        self.loginButton.hide { self.activityIndicator.startAnimating() }
        self.loginModel.login()
    }

}

extension LoginViewController: LoginModelDelegate {
    func loginModel(_ loginModel: LoginModel, didLogin result: Result<GitHubUser, LoginModelError>) {
        self.activityIndicator.stopAnimating()
        self.loginButton.show()
        
        switch result {
        case .success(let user):
            print(user)
        case .failure(let error):
            self.alert(error)
        }
    }
}
