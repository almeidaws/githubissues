//
//  IssuesViewController.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import Moya

class IssuesViewController: UITableViewController {
    
    private let provider = MoyaProvider<GitHubAPI>()
    private lazy var interfaceController = IssuesInterfaceController(self)
    private lazy var dataSource = IssuesDataSourceController(self)
    var login: Login?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupDelegates()
        self.interfaceController.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.requestSwiftIssues()
    }
    
    private func setupDelegates() {
        self.login?.delegate = self
        self.tableView.dataSource = self.dataSource
    }
    
    @objc func handleLogout() {
        self.alert(text: .title("Do you really wanna logout?")) { (option) in
            switch option {
            case .ok:
                self.login?.logout()
            case .cancel:
                break
            }
        }
    }
    
    @objc func handleRefreshControl() {
        self.requestSwiftIssues()
    }
    
    private func requestSwiftIssues(completion: (() -> Void)? = nil) {
        self.refreshControl?.beginRefreshing()
        self.provider.request(.allIssues(owner: "apple", repo: "swift")) { (result) in
            self.refreshControl?.endRefreshing()
            switch result {
            case .success(let moyaResponse):
                do {
                    self.dataSource.issues = try Array(moyaResponse)
                        .filter { $0.state != .all }
                        .sorted { $0.number > $1.number }
                    self.tableView.reloadData()
                    completion?()
                } catch {
                    self.alert(error)
                }
            case .failure(let error):
                self.alert(error)
            }
        }
    }
}


extension IssuesViewController: LoginDelegate {
    
    func login(_ login: Login, didLogout result: Result<Void, LoginModelError>) {
        switch result {
        case .success:
            self.dismiss(animated: true)
        case .failure(let error):
            if case .userCancelledLogin = error { return }
            self.alert(error)
        }
    }
}
