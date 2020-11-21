//
//  GFSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 10/5/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font  = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    func configure (){
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.90
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
