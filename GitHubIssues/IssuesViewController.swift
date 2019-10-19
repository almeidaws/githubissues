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
                debugPrint(moyaResponse.statusCode)
            case .failure(let error):
                self.alert(error)
            }
        }
    }
    
}
