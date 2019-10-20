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
    private let provider = MoyaProvider<AvatarAPI>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupIssue()
        self.setupNavigationControllerIfPresent()
    }
    
    private func setupNavigationControllerIfPresent() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Chevron"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(handleDismiss))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                                 target: self,
                                                                 action: #selector(handleOpenIssueURL))
    }
    
    @objc private func handleOpenIssueURL() {
        guard let issue = self.issue else { return }
        let activityController = UIActivityViewController(activityItems: [issue.htmlUrl],
                                                          applicationActivities: [TUSafariActivity()])
        self.present(activityController, animated: true, completion: nil)
    }
    
    @objc private func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupIssue() {
        guard let issue = self.issue else { return }
        self.title = "#\(issue.number)"
        self.titleLabel.text = issue.title
        self.creatorNickname.text = issue.user.login
        self.issueDescription.text = issue.body
        self.setCreationDateLabel()
        self.setIssueStateBadge()
        self.downloadUserImage()
    }
    
    private func setCreationDateLabel() {
        guard let issue = self.issue else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "'Created on 'dd/MM/yyyy' at 'HH:mm"
        formatter.locale = Locale.current
        let text = formatter.string(from: issue.createdAt)
        self.creationDate.text = text
    }
    
    private func setIssueStateBadge() {
        guard let issue = self.issue else { return }
        if case .closed = issue.state {
            self.issueStateImage.setClosedBadge()
        } else {
            self.issueStateImage.setOpenBadge()
        }
    }
    
    private func downloadUserImage() {
        guard let issue = self.issue else { return }
        self.creatorPhoto.hide(animated: false)
        self.provider.request(.avatar(id: issue.user.id)) { (result) in
            switch result {
            case .success(let moyaResponse):
                guard moyaResponse.statusCode == 200 else {
                    self.alert(MoyaProviderError.unexpectedStatusCode(moyaResponse.statusCode))
                    return
                }
                
                if let image = UIImage(data: moyaResponse.data) {
                    self.creatorPhoto.image = image
                    self.creatorPhoto.show()
                }
            case .failure(let error):
                self.alert(error)
            }
        }
    }
    
}
