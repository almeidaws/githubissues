//
//  IssuesDataSourceController.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

class IssuesDataSourceController: NSObject, UITableViewDataSource {
    
    var issues = [Issue]()
    private weak var controller: IssuesViewController?
    
    init(_ controller: IssuesViewController) {
        self.controller = controller
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let issue = self.issues[indexPath.row]
        guard let issueDetailController = self.controller?.defaultContainer.resolve(IssueDetailViewController.self) else {
            fatalError("There's no IssueDetailViewController to resolve.")
        }
        
        issueDetailController.issue = issue
        let navigation = UINavigationController(rootViewController: issueDetailController)
        navigation.modalPresentationStyle = .fullScreen
        self.controller?.present(navigation, animated: true, completion: nil)
    }
}
