//
//  FollowersListViewController.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/9/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class FollowersListViewController: UIViewController {
    
    enum Section {case main}

    var userName : String!
    var followers: [Follower] = []
    
    var colloectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
        
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
        colloectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColoumnFlowLayout(in: view))
        view.addSubview(colloectionView)
        colloectionView.backgroundColor = .systemBackground
        colloectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    func getFollowers(){
        NetworkManager.shared.getFollowers(for: userName, page: 1) {[weak self] (result) in
            guard let self = self else{
                return
            }
            switch(result){
            case .success(let followers):
                self.followers = followers
                self.updateData()
                
            case .failure(let error):
                self.presentGFAletOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource(){
        dataSource  = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: colloectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        //apply snapshot in
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
    }
    
}
