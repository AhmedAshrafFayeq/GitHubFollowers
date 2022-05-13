//
//  FollowersListViewController.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/9/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class FollowersListViewController: GFDataLoadingViewController {
    
    enum Section {case main}

    var username : String!
    var followers: [Follower]           = []
    var filteredFollower: [Follower]    = []
    var isSearching                     = false
    var page                            = 1
    var hasMoreFollowers                = true
    var isLoadingMoreFollowers          = false
    
    var colloectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username   = username
        title           = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController(){
        view.backgroundColor    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configureSearchController(){
        let searchController                                    = UISearchController()
        searchController.searchBar.placeholder                  = "Search for a username"
        searchController.searchResultsUpdater                   = self
        //when searching don't add alpha to the view
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
                        
    }
    
    
    func configureCollectionView(){
        colloectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColoumnFlowLayout(in: view))
        view.addSubview(colloectionView)
        colloectionView.delegate        = self
        colloectionView.backgroundColor = .systemBackground
        colloectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    
    func getFollowers(username: String, page: Int){
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, page: page) {[weak self] (result) in
            guard let self = self else{return}
            self.dismissLoadingView()
            switch(result){
            case .success(let followers):
                if followers.count < 100 {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                if followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😃."
                    DispatchQueue.main.async {self.showEmptyStateView(with: message, in: self.view)}
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGFAletOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "Ok")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    
    func configureDataSource(){
        dataSource  = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: colloectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        //apply snapshot in
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
    }
    
    
    @objc func addButtonTapped(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else{return}
                    
                    guard let error = error else{
                        self.presentGFAletOnMainThread(title: "Success", message: "You have successfully favorited this user 🎉", buttonTitle: "Hooray!")
                        return
                    }
                    self.presentGFAletOnMainThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentGFAletOnMainThread(title: "Somthing went wrong", message: error.rawValue
                    , buttonTitle: "Ok")
            }
        }
    }
}

extension FollowersListViewController : UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray             = isSearching ? filteredFollower : followers
        let follower                = activeArray[indexPath.item]
        
        let userInfoVC              = UserInfoViewController()
        userInfoVC.username         = follower.login
        userInfoVC.delegate         = self
        let navigationController    = UINavigationController(rootViewController: userInfoVC)
        present(navigationController, animated: true)        
    }
}

extension FollowersListViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter    = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollower.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching         = true
        filteredFollower    = followers.filter({$0.login.lowercased().contains(filter.lowercased())})
        updateData(on: filteredFollower)
    }
}

extension FollowersListViewController: UserInfoViewControllerDelegate{
    func didRequestFollowers(for username: String) {
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredFollower.removeAll()
        colloectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
