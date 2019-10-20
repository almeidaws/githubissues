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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resquestSwiftIssues()
    }
    
    private func resquestSwiftIssues() {
        self.provider.request(.allIssues(owner: "apple", repo: "swift")) { (result) in
            switch result {
            case .success(let moyaResponse):
                do {
                    self.issues = try Array(moyaResponse)
                        .filter { $0.state != .all }
                        .sorted { $0.number > $1.number }
                    self.tableView.reloadData()
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
}
