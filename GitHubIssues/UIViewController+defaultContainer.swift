//
//  UIViewController+defaultContainer.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import Swinject

extension UIViewController {
    var defaultContainer: Container {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("There's no accessible AppDelegate")
        }
        return appDelegate.container
    }
}
