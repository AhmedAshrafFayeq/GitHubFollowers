//
//  FollowersListViewController.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/9/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class FollowersListViewController: UIViewController {

    var userName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { (followers, errorMessage) in
            guard let followers = followers else{
                self.presentGFAletOnMainThread(title: "Bad stuff happend", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            print("followers.count= \(followers.count)")
            print(followers)
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
