//
//  AlertText.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

enum AlertText {
    case title(String)
    case message(String)
    case both(title: String, message: String)
}
