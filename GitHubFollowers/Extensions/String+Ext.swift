//
//  String+Ext.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 10/15/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import Foundation

extension String {
    
    func convertToDate() -> Date?{
        let dateFormatter   = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "en_US")
        dateFormatter.timeZone      = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String{
        guard let date = self.convertToDate() else {return "N/A"}
        return date.convertToMonthYearFormat()
    }
}
