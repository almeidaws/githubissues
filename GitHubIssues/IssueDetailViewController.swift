//
//  IssueDetailViewController.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import Moya
import TUSafariActivity

class IssueDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorPhoto: UIImageView!
    @IBOutlet weak var creatorNickname: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var issueStateImage: IssueStateBadgeImageView!
    @IBOutlet weak var issueDescription: UILabel!
    
    var issue: Issue?
    let provider = MoyaProvider<AvatarAPI>()
    private lazy var interfaceController = IssueDetailInterfaceController(self)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.interfaceController.setup()
    }
    
    @objc func handleOpenIssueURL() {
        guard let issue = self.issue else { return }
        let activityController = UIActivityViewController(activityItems: [issue.htmlUrl],
                                                          applicationActivities: [TUSafariActivity()])
        self.present(activityController, animated: true, completion: nil)
    }
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
