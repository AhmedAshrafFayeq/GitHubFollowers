//
//  GFTextField.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/8/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextField(){
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        placeholder                 = "Enter a username"
        returnKeyType               = .go
        translatesAutoresizingMaskIntoConstraints   = false
    }

}
