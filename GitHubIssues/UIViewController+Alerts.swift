//
//  UIViewController+Alerts.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit





extension UIViewController {
    
    func alert(text: AlertText, completion: @escaping (AlertOption) -> Void) {
        let okAction = UIAlertAction(title: AlertOption.ok.rawValue, style: .default) { _ in
            completion(.ok)
        }
        
        let cancelAction = UIAlertAction(title: AlertOption.cancel.rawValue, style: .default) { _ in
            completion(.cancel)
        }
        
        var alertTitle: String?
        var alertMessage: String?
        switch text {
        case .title(let title):
            alertTitle = title
        case .message(let message):
            alertMessage = message
        case .both(let title, let message):
            alertTitle = title
            alertMessage = message
        }
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alert(_ error: Error, completion: (() -> Void)? = nil) {
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let alert = UIAlertController(title: "An error has occured", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: completion)
    }
}
