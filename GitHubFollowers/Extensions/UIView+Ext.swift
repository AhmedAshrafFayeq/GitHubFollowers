//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 11/20/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

extension UIView{
    //varaidic parameters
    func addSubviews(_ views: UIView...){
        for view in views { addSubview(view) }
    }
    
    func pintToEdges(of superView: UIView){
        translatesAutoresizingMaskIntoConstraints   = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            
        ])
    }
}
