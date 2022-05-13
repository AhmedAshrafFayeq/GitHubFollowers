//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 10/15/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String{
        let dateFormatter   = DateFormatter()
        dateFormatter.dateFormat    = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
