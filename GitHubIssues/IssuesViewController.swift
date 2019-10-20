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
    private var issues = [Issue]()
    var login: Login?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationControllerIfPresent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestSwiftIssues()
        self.setupLogoutButton()
        self.setupDelegates()
    }
    
    private func setupDelegates() {
        self.login?.delegate = self
    }
    
    private func setupLogoutButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc private func handleLogout() {
        self.alert(text: .title("Do you really wanna logout?")) { (option) in
            switch option {
            case .ok:
                self.login?.logout()
            case .cancel:
                break
            }
        }
    }
    
    private func configureNavigationControllerIfPresent() {
        // Large title
        self.navigationController?.navigationBar.prefersLargeTitles = true
    
        // Refresh control
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        self.requestSwiftIssues()
    }
    
    private func requestSwiftIssues(completion: (() -> Void)? = nil) {
        self.refreshControl?.beginRefreshing()
        self.provider.request(.allIssues(owner: "apple", repo: "swift")) { (result) in
            self.refreshControl?.endRefreshing()
            switch result {
            case .success(let moyaResponse):
                do {
                    self.issues = try Array(moyaResponse)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let issue = self.issues[indexPath.row]
        
        let cell: IssueTableViewCell
        if case .closed = issue.state {
            guard let issueCell = tableView.dequeueReusableCell(withIdentifier: "closed", for: indexPath) as? IssueTableViewCell else {
                fatalError("Unable to found IssueTableViewCell for closed state.")
            }
            cell = issueCell
        } else {
            guard let issueCell = tableView.dequeueReusableCell(withIdentifier: "open", for: indexPath) as? IssueTableViewCell else {
                fatalError("Unable to found IssueTableViewCell for open state.")
            }
            cell = issueCell
        }
        
        cell.title.text = issue.title
        cell.number.text = "#\(issue.number)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let issue = self.issues[indexPath.row]
        guard let issueDetailController = self.defaultContainer.resolve(IssueDetailViewController.self) else {
            fatalError("There's no IssueDetailViewController to resolve.")
        }
        
        issueDetailController.issue = issue
        let navigation = UINavigationController(rootViewController: issueDetailController)
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: true, completion: nil)
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
