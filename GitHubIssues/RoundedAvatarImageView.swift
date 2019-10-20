//
//  RoundedAvatarImageView.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

class RoundedAvatarImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.becomeRounded()
    }
    
    private func becomeRounded() {
        self.layer.cornerRadius = 3
    }
}
