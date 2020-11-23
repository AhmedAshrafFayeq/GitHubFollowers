//
//  GFFollowerItemViewController.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 10/14/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import Foundation

protocol GFFollowerItemViewControllerDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemViewController: GFItemInfoViewController {
    weak var delegate: GFFollowerItemViewControllerDelegate!

    init(user: User, delegate: GFFollowerItemViewControllerDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
