//
//  IssueStateBadgeImageView.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

class IssueStateBadgeImageView: UIImageView {

    func setOpenBadge() {
        self.image = #imageLiteral(resourceName: "open_badge")
    }
    
    func setClosedBadge() {
        self.image = #imageLiteral(resourceName: "closed_badge")
    }
}
