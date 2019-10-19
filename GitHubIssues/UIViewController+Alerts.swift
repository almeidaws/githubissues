//
//  UIViewController+Alerts.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(_ error: Error, completion: (() -> Void)? = nil) {
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let alert = UIAlertController(title: "An error has occured", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: completion)
    }
}
