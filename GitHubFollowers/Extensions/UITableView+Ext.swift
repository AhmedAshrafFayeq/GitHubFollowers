//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 11/21/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
}
