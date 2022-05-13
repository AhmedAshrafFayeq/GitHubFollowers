//
//  GFTabBarController.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 11/7/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers                 = [creatSearchNavigationController(), createFavouriteNavigationController()]
    }
    
    func creatSearchNavigationController() -> UINavigationController {
        let searchNavigationController = SearchViewController()
        searchNavigationController.title = "Search"
        searchNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchNavigationController)
    }
    
    func createFavouriteNavigationController() -> UINavigationController {
        let favouriteNavigationController = FavouriteListViewController()
        favouriteNavigationController.title = "Favourite"
        favouriteNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouriteNavigationController)
    }
}
