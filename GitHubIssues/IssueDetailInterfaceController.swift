//
//  IssueDetailInterfaceController.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

class IssueDetailInterfaceController {
    private weak var controller: IssueDetailViewController?
    
    init(_ controller: IssueDetailViewController) {
        self.controller = controller
    }
    
    func setup() {
        self.setupNavigationControllerIfPresent()
        self.setupIssue()
    }
    
    private func setupNavigationControllerIfPresent() {
        guard let controller = self.controller else { return }
        self.controller?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Chevron"),
                                                                            style: .plain,
                                                                            target: controller,
                                                                            action: #selector(IssueDetailViewController.handleDismiss))
        self.controller?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                                             target: controller,
                                                                             action: #selector(IssueDetailViewController.handleOpenIssueURL))
    }
    
    private func setupIssue() {
        guard let issue = self.controller?.issue else { return }
        self.controller?.title = "#\(issue.number)"
        self.controller?.titleLabel.text = issue.title
        self.controller?.creatorNickname.text = issue.user.login
        self.controller?.issueDescription.text = issue.body
        self.setCreationDateLabel()
        self.setIssueStateBadge()
        self.downloadUserImage()
    }
    
    private func setCreationDateLabel() {
        guard let issue = self.controller?.issue else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "'Created on 'dd/MM/yyyy' at 'HH:mm"
        formatter.locale = Locale.current
        let text = formatter.string(from: issue.createdAt)
        self.controller?.creationDate.text = text
    }
    
    private func setIssueStateBadge() {
        guard let issue = self.controller?.issue else { return }
        if case .closed = issue.state {
            self.controller?.issueStateImage.setClosedBadge()
        } else {
            self.controller?.issueStateImage.setOpenBadge()
        }
    }
    
    private func downloadUserImage() {
        guard let issue = self.controller?.issue else { return }
        self.controller?.creatorPhoto.hide(animated: false)
        self.controller?.provider.request(.avatar(id: issue.user.id)) { (result) in
            switch result {
            case .success(let moyaResponse):
                guard moyaResponse.statusCode == 200 else {
                    self.controller?.alert(MoyaProviderError.unexpectedStatusCode(moyaResponse.statusCode))
                    return
                }
                
                if let image = UIImage(data: moyaResponse.data) {
                    self.controller?.creatorPhoto.image = image
                    self.controller?.creatorPhoto.show()
                }
            case .failure(let error):
                self.controller?.alert(error)
            }
        }
    }
}
