//
//  IssuesInterfaceController.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

class IssuesInterfaceController {
    
    private weak var controller: IssuesViewController?
    
    init(_ controller: IssuesViewController) {
        self.controller = controller
    }
    
    func setup() {
        self.configureNavigationControllerIfPresent()
        self.setupLogoutButton()
    }
    
    private func configureNavigationControllerIfPresent() {
        guard let controller = self.controller else { return }
        // Large title
        controller.navigationController?.navigationBar.prefersLargeTitles = true
    
        // Refresh control
        controller.refreshControl = UIRefreshControl()
        controller.refreshControl?.addTarget(controller, action: #selector(IssuesViewController.handleRefreshControl), for: .valueChanged)
    }
    
    private func setupLogoutButton() {
        guard let controller = self.controller else { return }
        
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: controller, action: #selector(IssuesViewController.handleLogout))
    }
}
