//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/29/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            switch result {
                
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGFAletOnMainThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configure(){
        view.backgroundColor                = .systemBackground
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem    = doneButton
    }
    
    @objc func dismissVC(){
        self.dismiss(animated: true)
    }

}
