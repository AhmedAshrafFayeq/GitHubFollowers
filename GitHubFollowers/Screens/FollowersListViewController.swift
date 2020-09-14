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
    var colloectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    func configureCollectionView(){
        colloectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColoumnFlowLayout())
        view.addSubview(colloectionView)
        colloectionView.backgroundColor = .systemPink
        colloectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    func createThreeColoumnFlowLayout() -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func getFollowers(){
        NetworkManager.shared.getFollowers(for: userName, page: 1) { (result) in
            
            switch(result){
            case .success(let followers):
                print("followers.count= \(followers.count)")
            
            case .failure(let error):
                self.presentGFAletOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
}
