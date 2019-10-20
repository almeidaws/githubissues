//
//  IssuesViewController.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import Moya

class IssuesViewController: UIViewController {
    
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
                    debugPrint(self.issues)
                } catch {
                    self.alert(error)
                }
            case .failure(let error):
                self.alert(error)
            }
        }
    }
    
}
