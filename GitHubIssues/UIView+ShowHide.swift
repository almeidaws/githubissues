//
//  UIView+ShowHide.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

extension UIView {
    func hide(completion: (() -> Void)? = nil) {
        self.isUserInteractionEnabled = false
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 0
        }, completion: { position in
            guard position == .end else { return }
            completion?()
        })
    }
    
    func show(completion: (() -> Void)? = nil) {
        self.isUserInteractionEnabled = true
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 1
        }, completion: { position in
            guard position == .end else { return }
            completion?()
        })
    }
}
