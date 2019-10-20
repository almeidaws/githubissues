//
//  UIView+ShowHide.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

extension UIView {
    func hide(animated: Bool = false, completion: (() -> Void)? = nil) {
        self.isUserInteractionEnabled = false
        if animated {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.alpha = 0
            }, completion: { position in
                guard position == .end else { return }
                completion?()
            })
        } else {
            self.alpha = 0
            completion?()
        }
        
    }
    
    func show(animated: Bool = false, completion: (() -> Void)? = nil) {
        self.isUserInteractionEnabled = true
        if animated {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.alpha = 1
            }, completion: { position in
                guard position == .end else { return }
                completion?()
            })
        } else {
            self.alpha = 1
            completion?()
        }
        
    }
}
