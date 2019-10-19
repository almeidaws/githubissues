//
//  RoundedLoginButton.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

class RoundedLoginButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundCorners()
    }
    
    private func roundCorners() {
        self.layer.cornerRadius = 6
    }
}
