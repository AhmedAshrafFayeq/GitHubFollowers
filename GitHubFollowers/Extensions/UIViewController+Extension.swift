//
//  UIViewController+Extension.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/10/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentGFAletOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertViewController = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle  = .overFullScreen
            alertViewController.modalTransitionStyle    = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
    
}
