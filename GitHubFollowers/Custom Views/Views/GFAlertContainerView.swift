//
//  GFAlertContainerView.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 11/20/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class GFAlertContainerView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(){
        backgroundColor = .systemBackground
        layer.cornerRadius    = 16
        layer.borderWidth     = 2
        //white border appears in dark mode
        layer.borderColor     = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
