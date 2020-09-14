//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/14/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeholderImage    = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}
