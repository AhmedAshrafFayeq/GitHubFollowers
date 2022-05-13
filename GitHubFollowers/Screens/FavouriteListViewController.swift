//
//  FavouriteListViewController.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/8/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class FavouriteListViewController: GFDataLoadingViewController {
    let tableView               = UITableView()
    var favorites:[Follower]    = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController(){
        view.backgroundColor    = .systemBackground
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
    }
    
    func getFavorites(){
        PersistenceManager.retrieveFavorites { [weak self]result in
            guard let self = self else {return}
            switch result{
            case .success(let favorites):
                if favorites.isEmpty{
                    self.showEmptyStateView(with: "No Favorites!\nAdd one on the followers screen ", in: self.view)
                }else{
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
        
            case .failure(let error):
                self.presentGFAletOnMainThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FavouriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite            = favorites[indexPath.row]
        let followerListVC      = FollowersListViewController(username: favorite.login)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}

        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self   = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentGFAletOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok ")
        }
        if favorites.isEmpty{
            self.showEmptyStateView(with: "No Favorites!\nAdd one on the followers screen ", in: self.view)
        }
    }
}
